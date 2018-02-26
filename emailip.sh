#!/bin/bash

# this program check the router WAN IP,  if changed sending email
# created by HW Wong
#e.g    . ./emailip.sh sender@abc.com  receiver@abc.com


if [ $# -lt 2 ]
then
  echo  "wrong email"
  exit 1
fi


WAN_IP="$(cat ip.txt)"
echo "Last time IP:" $WAN_IP

ip=$(curl ipinfo.io/ip)
echo $ip > ip.txt
echo "Current router WAN IP:" $ip

if [ "$WAN_IP" != "$ip" ]
then

echo sending email....

ssmtp  $2 << EOF
To: $2
From: $1
Subject: Home IP address updated!

Dear Host,

Your home IP address is changed to $ip

best regards.
Slave :P

EOF

  echo Done!

else
  echo "IP no changed"
fi
