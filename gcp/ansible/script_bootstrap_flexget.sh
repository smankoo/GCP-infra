sudo useradd flexget -G sudo
echo -e "${random_string.password.result}\n${random_string.password.result}" | sudo passwd flexget
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
