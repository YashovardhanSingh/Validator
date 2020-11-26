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

#NETWORK_SIGN_KEY = 46a23fd52b2690f5acf56654489fd67b3734a52f35a2b7827f5caeaa06c0c0a5
#Creating validator_pv_run ... done
#Waiting for postgres...
#PostgreSQL started
#Enter node identifier (required): 8ecf3ff5cc8b6b9db7077f9776043b21d22a59544056add03bdfa4c8b35a13bd
#Enter account number (required): 7ac95e3083c35a8fe395b55a154cc61c89416d994a7109800b781b00aa1de2da
#Enter default transaction fee (required): 1
#Enter node_type (required): CONFIRMATION_VALIDATOR
#Enter seed block identifier:
#Enter protocol (required): http
#Enter public IP address (required): 192.168.100.2
#Enter port: 8002
#Enter root account file URL (required): https://gist.githubusercontent.com/buckyroberts/395c946b33b9a458d677c919ae3f00b1/raw/55acc740cb25d2b4d02430f096b225e70677ec23/alpha-02.json
#Enter version (required): v1.0
