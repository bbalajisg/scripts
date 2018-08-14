#!/bin/bash


#Defining constants

declare -r INVALID_CHAR='#-'

function get_from_property {
       
        local key="$1"
	while read -r line
        do
        	local prop_value
		if !  [[ $line =~ ^[$INVALID_CHAR]  ]]; then
		
			if [[  $(echo "$line" | cut -d'=' -f1)= = $key ]]; then
		
		        	local SUBSTRING
				SUBSTRING=$(echo "$line" | cut -d'=' -f2)
		    
				echo $key$SUBSTRING >> $NEW_DB_PROP_FILE 
				break
		  	fi
	        fi

	done < "$2" 
}

function find_n_append {
	
	get_from_property "$1" "$APP_PROP_FILE"
	get_from_property "$1" "$DB_PROP_FILE"
}


function read_dbprop_template {
	
	while read -r line
	do 
		if ! [[ $line =~ ^[$INVALID_CHAR] || "$line" =~ ^$  ]]; then
			 find_n_append "$line"
		else
			echo $line >> $NEW_DB_PROP_FILE
		fi
        done < "$1"
}

function mkdir_temp_cd {
	mkdir -p "$1"/tmp 
	cd $_ || return 
	echo pwd
}

# if [ "$#" -le 5 ]

DATE=$(date +"%d%m%Y")
parent_path="$(cd "$( dirname "${BASHSOURCE[0]}"  )" && pwd )"	

TMP_PATH=mkdir_temp_cd "${parent_path}"
echo pwd

DB_PROP_TEMPLATE="${parent_path}"/application-DB-template.properties
APP_PROP_FILE="${parent_path}"/application-app.properties
DB_PROP_FILE="${parent_path}"/application-DB.properties
NEW_DB_PROP_FILE="${parent_path}"/application-DB.properties.new 

cp /dev/null $NEW_DB_PROP_FILE
echo '' > $NEW_DB_PROP_FILE
cp -p $DB_PROP_FILE $DB_PROP_FILE-backup_$DATE
cp -p $APP_PROP_FILE $APP_PROP_FILE-backup_$DATE
read_dbprop_template $DB_PROP_TEMPLATE

exit 0
