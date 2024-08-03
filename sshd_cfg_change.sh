#!/bin/bash
clear

# Backup the configuration file
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak

# Check and replace "prohibit-password"
if grep -q "prohibit-password" /etc/ssh/sshd_config; then
    sed -i "s/prohibit-password/yes/g" /etc/ssh/sshd_config
fi

# Check and replace "without-password"
if grep -q "without-password" /etc/ssh/sshd_config; then
    sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
fi

# Check and replace "#PermitRootLogin"
if grep -q "#PermitRootLogin" /etc/ssh/sshd_config; then
    sed -i "s/#PermitRootLogin/PermitRootLogin prohibit-password/g" /etc/ssh/sshd_config
fi

# Ensure "PasswordAuthentication" is present
if ! grep -q "PasswordAuthentication" /etc/ssh/sshd_config; then
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
fi

# Check and replace "PasswordAuthentication no"
if grep -q "PasswordAuthentication no" /etc/ssh/sshd_config; then
    sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
fi

# Check and replace "#PasswordAuthentication no"
if grep -q "#PasswordAuthentication no" /etc/ssh/sshd_config; then
    sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
fi

# Restart the SSH service
service ssh restart > /dev/null

