#!/bin/bash
#
# Issue (or renew) the HTTPS certificate for the notes app's LAN IP from a
# private CA, creating the CA on first run. The CA is name-constrained to the
# IP's /24, so even if its key leaked it could not impersonate other sites.
# Devices must trust ${CA_DIR}/ca.crt once; renewing reuses the same CA.
#
# Usage: sudo ./notes-cert.sh <ip>     e.g. sudo ./notes-cert.sh 192.168.88.60

set -euo pipefail

readonly CA_DIR='/etc/ssl/notes-ca'
readonly CA_DAYS=3650
# Apple rejects certs from private CAs valid for more than 825 days.
readonly CERT_DAYS=825

#######################################
# Create the name-constrained CA unless it already exists.
# Globals:
#   CA_DIR, CA_DAYS
# Arguments:
#   Server IP; the CA is limited to its /24.
#######################################
create_ca() {
  local ip="$1"
  # Keyed on the cert: a run that died after creating only the key restarts.
  [[ -f "${CA_DIR}/ca.crt" ]] && return 0

  echo "Creating CA for ${ip%.*}.0/24 in ${CA_DIR}"
  (umask 077 && openssl genpkey -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-256 -out "${CA_DIR}/ca.key")
  # Only one IPv4 /24 and a dummy DNS name are permitted, which blocks every
  # real hostname and IPv6 address.
  openssl req -x509 -new -key "${CA_DIR}/ca.key" -sha256 -days "${CA_DAYS}" \
    -subj "/CN=Notes Home CA (${ip%.*}.x)" \
    -addext 'basicConstraints=critical,CA:TRUE,pathlen:0' \
    -addext 'keyUsage=critical,keyCertSign,cRLSign' \
    -addext "nameConstraints=critical,permitted;IP:${ip%.*}.0/255.255.255.0,permitted;DNS:notes.invalid" \
    -out "${CA_DIR}/ca.crt"
  chmod 644 "${CA_DIR}/ca.crt"
}

#######################################
# Issue a fresh server certificate for the IP, signed by the CA.
# Globals:
#   CA_DIR, CERT_DAYS
# Arguments:
#   Server IP.
#######################################
issue_cert() {
  local ip="$1"
  local csr
  csr="$(mktemp)"
  echo "Issuing certificate for ${ip} (${CERT_DAYS} days)"
  (umask 077 && openssl genpkey -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-256 -out "${CA_DIR}/notes.key.new")
  # The IP goes only in the SAN: a hostname-like CN would be checked against
  # the CA's DNS constraint and fail in OpenSSL-based clients such as curl.
  openssl req -new -key "${CA_DIR}/notes.key.new" -subj '/CN=Notes app' \
    -out "${csr}"
  openssl x509 -req -in "${csr}" -CA "${CA_DIR}/ca.crt" \
    -CAkey "${CA_DIR}/ca.key" -set_serial "0x$(openssl rand -hex 16)" \
    -days "${CERT_DAYS}" -sha256 -out "${CA_DIR}/notes.crt.new" \
    -extfile <(printf '%s\n' \
      "subjectAltName=IP:${ip}" \
      'basicConstraints=critical,CA:FALSE' \
      'keyUsage=critical,digitalSignature' \
      'extendedKeyUsage=serverAuth')
  rm -f "${csr}"
  openssl verify -CAfile "${CA_DIR}/ca.crt" "${CA_DIR}/notes.crt.new" \
    >/dev/null
  chmod 644 "${CA_DIR}/notes.crt.new"
  # Swap in key and cert together, only after the new pair verified.
  mv "${CA_DIR}/notes.key.new" "${CA_DIR}/notes.key"
  mv "${CA_DIR}/notes.crt.new" "${CA_DIR}/notes.crt"
}

main() {
  if (( $# != 1 )); then
    echo "Usage: sudo $0 <ip>" >&2
    exit 2
  fi
  local ip="$1"
  if [[ ! "${ip}" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
    echo "Not an IPv4 address: ${ip}" >&2
    exit 2
  fi
  if (( EUID != 0 )); then
    echo "Run as root (sudo): the keys are root-only" >&2
    exit 1
  fi

  install -d -m 755 "${CA_DIR}"
  create_ca "${ip}"
  issue_cert "${ip}"
  openssl x509 -in "${CA_DIR}/notes.crt" -noout -subject -enddate \
    -ext subjectAltName

  # Reload nginx if it already uses the cert; skip on first setup. -R, not
  # -r: sites-enabled entries are symlinks.
  if grep -Rqs "${CA_DIR}/notes.crt" /etc/nginx/sites-enabled/; then
    nginx -t && systemctl reload nginx && echo "nginx reloaded"
  fi
}

main "$@"
