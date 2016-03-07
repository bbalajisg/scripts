#!/usr/bin/env bash

# Done for noggin for data encryption for data-at-rest. executed while docker is started and stopped.
#Set this variable to your mount passphrase. Ideally you'd get this from $1 input so that the actual value isn't stored in bash script. That would defeat the purpose.
mountphrase='balabala'

#Add tokens into user session keyring
printf "%s" "${mountphrase}" | ecryptfs-add-passphrase > tmp.txt

#Now get the signature from the output of the above command
sig=`tail -1 tmp.txt | awk '{print $6}' | sed 's/\[//g' | sed 's/\]//g'`
rm -f tmp.txt #Remove temp file

#Now perform the mount
sudo mount -t ecryptfs -o key=passphrase:passphrase_passwd=${mountphrase},no_sig_cache=yes,verbose=no,ecryptfs_sig=${sig},ecryptfs_cipher=aes,ecryptfs_key_bytes=16,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=no /home/user/.Private /home/user/Private
