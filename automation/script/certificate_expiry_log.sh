#!/bin/bash


function create_log {
        CERT_INFO_PATH="${PARENT_PATH}"/"${FILE_NAME}"

	if [[ ! -e  "${CERT_INFO_PATH}" ]]; then
		touch "${CERT_INFO_PATH}"
	fi

}

DATE=$(date +"%d%m%Y")
FILE_NAME="${DATE}"_cert_info.json
PARENT_PATH="$(cd "$( dirname "${BASHSOURCE[0]}"  )" && pwd )"

create_log

exit
