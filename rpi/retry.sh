#!/bin/bash
#
# Created by Felipe Machado - 2016/02/14
#
# A retry command for bash
# Retries the given command up to MAX_RETRIES, with an interval of SLEEP_TIME
# between each retry. Just put it on your bash_profile and be happy :)
# Usage:
#   retry [-s SLEEP_TIME] [-m MAX_RETRIES] COMMAND_WITH_ARGUMENTS
#
# Codes used as reference:
# - http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# - https://gist.github.com/iangreenleaf/279849
#


# Retry command
function retry() {
    SLEEP_TIME="30"
    MAX_RETRIES="10"

    # Command-line arguments parsing
    while [[ $# > 0 ]]
    do
    key="$1"

    case $key in
        -s|--sleep)
        SLEEP_TIME="$2"
        shift # past argument
        ;;
        -m|--max)
        MAX_RETRIES="$2"
        shift # past argument
        ;;
        -h|--help)
        echo """A retry command for bash.
Usage:
    retry [-s SLEEP_TIME] [-m MAX_RETRIES] COMMAND_WITH_ARGUMENTS"""
        return 0
        ;;
        *)
        break # unknown option
        ;;
    esac
    shift # past argument or value
    done

    # The command is all remaining arguments
    COMMAND=`printf "%q " "$@"`

    if [ "$(echo $COMMAND)" == "''" ]
    then
        echo "No command given"
        return 2
    fi

    echo $COMMAND

    i=0

    # I'm using eval to allow for pipes. This could become an option
    eval $COMMAND

    while [ $? -ne 0 -a $i -lt $MAX_RETRIES ]
    do
        echo "Command failed - retrying in $SLEEP_TIME..."
        sleep $SLEEP_TIME
        i=$(($i+1))
        eval $COMMAND
    done

    if [ $i -eq $MAX_RETRIES ]
    then
        echo "Max retries reached"
        return 1
    fi
}
