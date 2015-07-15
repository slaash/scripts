#!/bin/bash

dir=${1}

for name in $(sudo find ${dir} -type f 2>/dev/null); do
    host=$(hostname -s)
    id=$(echo -n "${host}${name}"|sha256sum|cut -d " " -f 1)
    size=$(stat -c "%s" ${name})
    type=$(file -b ${name})
    mode=$(stat -c "%a" ${name})
    user=$(stat -c "%U" ${name})
    group=$(stat -c "%G" ${name})
    if [[ -e "${name}" ]]; then
        echo "${name}: ${host} ${size} ${type} ${mode} ${user} ${group}"
        curl -s -X POST "http://localhost:9200/files/file/${id}" -d "
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

