#!/bin/bash

LOGFILE=~/script.log
ERRORFILE=~/errors.log

cd /usr/src
# Not needed ?!
# wget http://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz

echo "----- Get files needed for installing Asterisk -----"
echo "----- pjproject -----"
if ! [ -f /usr/src/pjproject-2.tar.bz2 ]
    then wget -O pjproject-2.tar.bz2 http://www.pjsip.org/release/2.5.5/pjproject-2.5.5.tar.bz2 -q --show-progress
fi

echo "----- jansson -----"
echo "----- Fetch jansson -----" >> $LOGFILE
if ! [ -f /usr/src/jansson.tar.gz ]
    then wget -O jansson.tar.gz https://github.com/akheron/jansson/archive/v2.8.tar.gz -q --show-progress
fi

echo "----- Asterisk -----"
echo "----- Fetch Asterisk -----" >> $LOGFILE
if ! [ -f /usr/src/asterisk-14.tar.gz ]
    then wget -O asterisk-14.tar.gz http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-14-current.tar.gz -q --show-progress
fi

dialog --pause 'Download OK!' 10 60 10 --

echo "Compile and install pjproject"
echo "--------------------------------" >>$LOGFILE
echo "Compile and install pjproject" >>$LOGFILE
echo "--------------------------------" >>$LOGFILE
cd /usr/src
mkdir /usr/src/pjproject-2
tar -xjvf pjproject-2.tar.bz2 --directory /usr/src/pjproject-2 --strip-components=1
cd pjproject-2
CFLAGS='-DPJ_HAS_IPV6=1' ./configure --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr
make dep && make && make install

dialog --pause 'Jansson!' 10 60 10 --

echo "Compile and install jansson"
echo "--------------------------------" >>$LOGFILE
echo "Compile and install jansson" >>$LOGFILE
echo "--------------------------------" >>$LOGFILE
cd /usr/src

tar vxfz jansson.tar.gz
cd jansson-*
autoreconf -i
./configure
make && make install && ldconfig

dialog --pause 'Asterisk!' 10 60 10 --

echo "Install Asterisk"
echo "--------------------------------" >>$LOGFILE
echo "Install Asterisk" >>$LOGFILE
echo "--------------------------------" >>$LOGFILE
cd /usr/src
mkdir /usr/src/asterisk-14
tar xvfz asterisk-14.tar.gz --directory /usr/src/asterisk-14 --strip-components=1
cd asterisk-14

dialog --pause 'Asterisk Contrib!' 10 60 10 --

contrib/scripts/get_mp3_source.sh
contrib/scripts/install_prereq install
./configure

dialog --pause 'Asterisk maker menuselect and then compile!' 10 60 10 --



