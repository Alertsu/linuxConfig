#!/bin/bash
echo "#########install software start#########"

echo "---------update apt-get url resources--------"
echo `cat ./sources.listbak>/etc/apt/sources.list`
echo "---------Over update apt-get url resources--------"


echo "---------update apt-get---------"
echo `apt-get -y update`
echo "---------over update apt-get---------"


echo "----------install emacs----------"
echo `apt-get -y install emacs`
echo "----------over install emacs----------"

echo "----------install git----------"
echo `apt-get -y install git`
echo "----------over install git----------"

echo "----------install aria2----------"
echo `apt-get -y install aria2`
echo "----------over install aria2----------"

echo  "----------install chrommiu----------"
echo `apt-get -y install chrommiu`
echo  "----------over install chrommiu----------"

echo  "----------install fcitx-sunpinyin----------"
echo `apt-get -y install fcitx-sunpinyin`
echo  "----------over install fcitx-sunpinyin---------"

echo  "----------install myplayer----------"
echo `apt-get -y install myplayer`
echo  "----------over install myplayer---------"

echo  "----------install sdcv----------"
echo `apt-get -y install sdcv`
echo  "----------over install sdcv---------"

echo  "----------install shadowsocks----------"
echo `apt-get -y install shadowsocks`
echo  "----------over install shadownsocks---------"

echo  "----------download sdcv dictionary----------"
echo `aria2c -x5  http://abloz.com/huzheng/stardict-dic/zh_CN/stardict-oxford-gb-2.4.2.tar.bz2`
echo `aria2c  -x5     http://abloz.com/huzheng/stardict-dic/zh_CN/stardict-oxford-gb-2.4.2.tar.bz2`
echo  "----------over download  sdcv dictionary---------"

echo  "----------sdcv dictionay config----------"
echo `mkdir /usr/share/stardict/dic`
echo `cp stardict*.tar.bz2  /usr/share/stardict/dic`
echo `tar -jxvf /usr/sharestardict/dic/stardict*`
echo `rm /usr/sharestardict/dic/*.tar.bz2`
echo  "----------over sdcv dictionary config---------"

echo  "----------shadowsocks config----------"
echo `cp config.json /etc/shadowsocks/config.json`
echo `rm config.json`
echo  "----------over shadownsocks config---------"


echo "#########Over#########"
