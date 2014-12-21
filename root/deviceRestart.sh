#!/bin/sh

usr=admin
pwd=atlanta
ip=192.168.0.1
tmp=/tmp/deviceRestart
cookies=cookies.txt

#improve the logread output
sqm_logger() {
    logger -t SQM -s ${1}
}

[ -d $tmp ] || mkdir -p $tmp

logger "Testing UMW connectivity ..."

ping -q -c5 google.com > /dev/null
 
if [ $? -ne 0 ]
then
	logger "Restarting UMW ..."
	wget --save-cookies $cookies $ip/goform/Docsis_system --post-data="username_login=$usr&password_login=$pwd&LanguageSelect=en&Language_Submit=0&login=Log+In" --keep-session-cookies -O /dev/null
 	wget $ip/goform/Devicerestart --post-data="username_login=$usr&password&devicerestrat_Password_check=$pwd&mtenRestore=Device+Restart&devicerestart=1&devicerestrat_getUsercheck=true&h_devicerestrat=" --load-cookies $cookies -O /dev/null
	rm $cookies
fi
