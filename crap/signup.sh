#!/usr/bin/env bash

export LOCAL_STORAGE=/quicksave-storage

export HOSTIP=`hostname -I | cut -d" " -f1`

export USERNAME=${USER}
read -s -p "Enter password: " password
echo
read -s -p "Repeat Password: " password2
echo

if [[ "${password}" != "${password2}" ]];
then
    echo "Passwords do not match"
    exit
fi

export KEY_PRIV=/root/.ssh/quicksave_storage_id_rsa
export KEY_PUB=${KEY_PRIV}.pub

export SQLITE_MASTER_DB=master.db
export SQLITE_MASTER_SQL=master.sql
export SQLITE_USER_DB=${USERNAME}.db
export SQLITE_USER_SQL=${USERNAME}.sql

[[ ! -e io_quicksave_libbeans ]] && git clone https://github.com/adiog/io_quicksave_libbeans

./io_quicksave_libbeans/sqlbeans/create_database_master_sqlite_insert_user_scripts.sh \
     ${USERNAME} \
     ${password} \
     sqlite:///storage/host/${SQLITE_USER_DB} \
     file:///storage/host/files/${USERNAME} \
         > ${SQLITE_MASTER_SQL}

rm -fr io_quicksave_libbeans

sudo docker exec storage_quicksave_docker mkdir -p /storage/host
sudo docker cp ${SQLITE_MASTER_SQL} storage_quicksave_docker:/storage/${SQLITE_MASTER_SQL}
rm -fr ${SQLITE_MASTER_SQL}
sudo docker exec storage_quicksave_docker sqlite3 /storage/${SQLITE_MASTER_DB} ".read /storage/${SQLITE_MASTER_SQL}"

sudo docker exec storage_quicksave_docker mkdir -p /root/.ssh

sudo docker exec storage_quicksave_docker ssh-keygen -t rsa -f ${KEY_PRIV} -N ''

sudo docker cp storage_quicksave_docker:/root/.ssh/$(basename ${KEY_PUB}) $(basename ${KEY_PUB})
cat $(basename ${KEY_PUB}) | sudo tee /root/.ssh/authorized_keys
rm -fr $(basename ${KEY_PUB})

sudo docker exec storage_quicksave_docker mkdir -p /storage/host
sudo docker exec storage_quicksave_docker ls /root/.ssh/
sudo docker exec storage_quicksave_docker ssh-keyscan ${HOSTIP} > known_hosts
sudo docker cp known_hosts storage_quicksave_docker:/root/.ssh/known_hosts
rm -fr known_hosts
sudo docker exec storage_quicksave_docker sshfs ${HOSTIP}:${LOCAL_STORAGE} /storage/host -o IdentityFile=/root/.ssh/$(basename ${KEY_PRIV}) -o idmap=user
