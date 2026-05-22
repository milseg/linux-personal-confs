#!/bin/bash
$CONFDIR=/home/youruser/

echo "Running xmodmap..." > /tmp/keymappings.log

#place swap_keys.xmodmap at the same place in your system
xmodmap $CONFDIR/custom/swap_keys.xmodmap >> /tmp/keymappings.log 2>&1

# Executa o autokey para carregar hotkeys programadas em segundo plano e redireciona a saída para /dev/null
if ! pgrep -x "autokey" > /dev/null; then 
   nohup autokey > /dev/null 2>/dev/null &
fi


#sleep 1

#echo "pkill autokey" | at now + 1 minute
# Pega o PID do último comando em background
# PID=$!

# echo "kill $PID" | at now + 1 MINUTE

