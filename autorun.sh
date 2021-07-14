#!/bin/bash
#1.更新apt为清华大学的源
echo "1.更新apt为清华大学的源"
sudo bash -c "cat ./sources.listbak >/etc/apt/sources.list"

#2.更新apt
echo "2.更新apt"
sudo apt update -y

#3.安装一些常用软件
echo "3.安装一些常用软件 zsh openssh-server git aria2  sdcv shadowsocks-libev fcitx-sunpinyin chromium curl"
sudo apt install  zsh openssh-server git aria2 sdcv shadowsocks-libev fcitx-sunpinyin chromium curl  -y

#4.配置一些软件
echo "#4.1 记录当前工作地址"
workSpace=`pwd`

echo "#4.2 配置sdcv字典"
aria2c -s10 -x16  http://download.huzheng.org/zh_CN/stardict-langdao-ec-gb-2.4.2.tar.bz2
aria2c -s10 -x16 http://download.huzheng.org/zh_CN/stardict-langdao-ce-gb-2.4.2.tar.bz2

sudo mkdir -p /usr/share/stardict/dic

sudo cp stardict*.tar.bz2  /usr/share/stardict/dic

rm -rf stardict-langdao*

for stardic in /usr/share/stardict/dic/*.tar.bz2
do
    cd  /usr/share/stardict/dic/
    sudo bash -c "tar -jxvf $stardic"
    sudo rm -rf $stardic
done

echo "#4.3 配置shadowsocks"
sudo mkdir -p /etc/shadowsocks

sudo bash -c 'cat > /etc/shadowsocks-libev/config.json << EOF
{
    "server":["46.17.46.39", "45.129.2.28","45.147.201.99"],
    "server_port":1988,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"lncn.org w6",
    "timeout":300,
    "method":"rc4",
    "fast_open": false,
    "workers": 1
}
EOF'

echo "#4.4 配置oh_my_zsh"
sudo apt install autojump -y

cd $workSpace
chmod +x ohmyzsh_insall.sh
./ohmyzsh_insall.sh
wait 
# 将命令在后台执行
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions & 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions &
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search &

# 等待当前脚本进程下的子进程结束
wait
sed -i "s/git)/git autojump zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search)/g" ~/.zshrc
source ~/.zshrc


echo "#4.5 使用官方安装脚本自动安装Docker"
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

echo "#4.6 下载docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version


