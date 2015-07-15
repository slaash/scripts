#!/usr/bin/env bash

dir=${1}
if [[ -z "$2" ]];then
    srv="localhost"
else
    srv=${2}
fi

echo "${srv}"

for name in $(sudo find ${dir} -type f 2>/dev/null); do
    host=$(hostname -s)
    type=$(file -b ${name})
    if [[ $(uname) == "Linux" ]]; then
        id=$(echo -n "${host}${name}"|sha256sum|cut -d " " -f 1)
        size=$(stat -c "%s" ${name})
        mode=$(stat -c "%a" ${name})
        user=$(stat -c "%U" ${name})
        group=$(stat -c "%G" ${name})
    elif [[ $(uname) == "FreeBSD" ]]; then
        id=$(echo -n "${host}${name}"|sha256|cut -d " " -f 1)
        size=$(stat -f "%z" ${name})
        mode=$(stat -f "%p" ${name})
        user=$(stat -f "%u" ${name}|id -un)
        group=$(stat -f "%g" ${name}|id -gn)
    else
        echo "$(uname) not set up yet"
        exit
    fi
    if [[ -e "${name}" ]]; then
        echo "${name}: ${host} ${size} ${type} ${mode} ${user} ${group}"
        curl -s -X POST "http://${srv}:9200/files/file/${id}" -d "
{
    \"host\": \"${host}\",
    \"name\": \"${name}\",
    \"size\": \"${size}\",
    \"type\": \"${type}\",
    \"mode\": \"${mode}\",
    \"user\": \"${user}\",
    \"group\": \"${group}\"
}"
        echo ""
    fi
done

