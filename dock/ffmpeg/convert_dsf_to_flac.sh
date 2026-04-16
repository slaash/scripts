#!/bin/bash
set -euo pipefail

# Usage: convert_dsf_to_flac.sh <SRCDIR> [DSTDIR]
# Converts all .dsf files in SRCDIR to FLAC.
# DSD is resampled to 88.2 kHz 24-bit PCM using the soxr resampler.

SRCDIR="${1:?Usage: $0 <SRCDIR> [DSTDIR]}"
DSTDIR="${2:-${SRCDIR}}"

FFMPEG=/opt/ffmpeg/bin/ffmpeg
SAMPLE_RATE=88200        # 88.2 kHz — change to 176400 for higher quality (larger files)
COMPRESSION=8            # FLAC compression 0-12 (8 = good balance)

# Use soxr resampler if ffmpeg was built with --enable-libsoxr; fall back to swr otherwise
if "${FFMPEG}" -buildconf 2>/dev/null | grep -q -- '--enable-libsoxr'; then
    RESAMPLE_FILTER=(-af "aresample=resampler=soxr")
    RESAMPLER="soxr"
else
    RESAMPLE_FILTER=()
    RESAMPLER="swr (soxr not available)"
fi

echo "=== DSF → FLAC Converter ==="
echo "Input dir:   ${SRCDIR}"
echo "Output dir:  ${DSTDIR}"
echo "Sample rate: ${SAMPLE_RATE} Hz"
echo "Resampler:   ${RESAMPLER}"
echo ""

DSF_COUNT=$(find "${SRCDIR}" -maxdepth 1 -iname "*.dsf" | wc -l)
if [ "${DSF_COUNT}" -eq 0 ]; then
    echo "ERROR: No .dsf files found in: ${SRCDIR}"
    exit 1
fi
echo "Found ${DSF_COUNT} .dsf file(s) to convert."
echo ""

mkdir -p "${DSTDIR}"

find "${SRCDIR}" -maxdepth 1 -iname "*.dsf" | sort | while read -r DSF_FILE; do
    BASENAME=$(basename "${DSF_FILE}" .dsf)
    FLAC_FILE="${DSTDIR}/${BASENAME}.flac"

    echo "Converting: ${BASENAME}.dsf"

    "${FFMPEG}" -y \
        -i "${DSF_FILE}" \
        -map 0:a \
        -map 0:v? \
        "${RESAMPLE_FILTER[@]}" \
        -ar "${SAMPLE_RATE}" \
        -c:a flac \
        -compression_level "${COMPRESSION}" \
        -bits_per_raw_sample 24 \
        -sample_fmt s32 \
        -c:v copy \
        -disposition:v attached_pic \
        -map_metadata 0 \
        "${FLAC_FILE}" \
        < /dev/null

    SIZE=$(du -h "${FLAC_FILE}" | cut -f1)
    echo "  ✓ Done → ${BASENAME}.flac (${SIZE})"
done

echo ""
echo "=== Complete ==="
echo "Output: ${DSTDIR}"
