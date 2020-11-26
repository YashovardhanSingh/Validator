#!/bin/sh

echo "Waiting for postgres..."
while ! nc -z db 5432; do
  sleep 0.1
done
echo "PostgreSQL started"

if [ "$1" = "" ]; then
  /opt/project/manage.py migrate;
  /opt/project/manage.py runserver 0.0.0.0:8000;
else
  exec "$@"
fi

#NETWORK_SIGN_KEY = 731f928711f30257d20bde471200c11975009415b4c6f596e7ee81bfed1a033b
#Creating validator_pv_run ... done
#Waiting for postgres...
#PostgreSQL started
#Enter node identifier (required): ed3b6d8e7ba1819ccedb17f9a7427b8e76b22dccf2bc130fc2386daf86ec80d3
#Enter account number (required): 7ac95e3083c35a8fe395b55a154cc61c89416d994a7109800b781b00aa1de2da
#Enter default transaction fee (required): 1
#Enter node_type (required): PRIMARY_VALIDATOR
#Enter seed block identifier:
#Enter protocol (required): http
#Enter public IP address (required): 192.168.100.2
#Enter port: 8001
#Enter root account file URL (required): https://gist.githubusercontent.com/buckyroberts/395c946b33b9a458d677c919ae3f00b1/raw/55acc740cb25d2b4d02430f096b225e70677ec23/alpha-02.json
#Enter version (required): v1.0
