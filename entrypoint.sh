#!/bin/bash
sleep 5

cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

if [[ install = *$MODIFIED_STARTUP* ]];then
	./arma3server auto-install
else
	if [[ update = *$MODIFIED_STARTUP* ]]; then
		./arma3server update
	else
		./arma3server start
	fi
fi

# Run the Server
${MODIFIED_STARTUP}
