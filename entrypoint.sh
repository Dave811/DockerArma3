#!/bin/bash
sleep 5

cd /home/container

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"



string='My long string'
if [[ &MODIFIED_STARTUP = *${WOOZLE_WOO}* ]]; then
  echo "It's there!"
else

fi


# Run the Server
${MODIFIED_STARTUP}
