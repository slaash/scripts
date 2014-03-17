#!/bin/bash
help="usage: ./parassh.sh -s <servers file> -t <timeout> <cmd>
by default <servers file> is \$HOME/servere.txt, <timeout> is 10
first parameter is (optionally) the command to run remotely"
#command to execute remotely
cmd="uname -a"
#ssh command timeout
t=10
#servers file
srvs="${HOME}/servere.txt"
OPTIND=1
while getopts "s:t:h" opt; do
        case "$opt" in
        s)
                srvs=$OPTARG
		if ! [[ -f "${srvs}" ]]; then
			echo "File ${srvs} not found!"
			exit
		fi
                ;;
        t)
		t=$OPTARG
                ;;
	*)
		echo "${help}"
		exit
		;;
        esac
done
shift $(($OPTIND - 1))
if [[ -n "${1}" ]]; then
	cmd="${1}"
fi
#ignore commented out lines
r="^#"
#separate user@address from port if separated by :
r1="(.+)\:([0-9]+)"
export TMPDIR="/tmp"
errFile=$(mktemp -t "tmpXXX")
for line in $(cat "${srvs}");
do
	if ! [[ ${line} =~ ${r} ]]; then
		if [[ ${line} =~ ${r1} ]]; then
			adr=${BASH_REMATCH[1]}
			port=${BASH_REMATCH[2]}
			echo "${adr}:${port}"
			timeout $t ssh -p ${port} ${adr} ${cmd} 2>${errFile}
		else
			echo "${line}"
			timeout $t ssh ${line} ${cmd} 2>${errFile}
		fi
		if ! (( $? == 0 )); then
			if (( $? == 124 )); then
				echo "Timeout!"
			else
				echo "Error $?"
				cat ${errFile}
			fi
		fi
	fi
done
rm ${errFile}

