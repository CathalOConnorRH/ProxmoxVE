#!/usr/bin/env bash

# Copyright (c) 2021-2025 tteck
# Author: Cathal O'Connor (cathaloconnorrh)
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y python3-dev python3-pip python3-virtualenv python3-venv python3-scapy libssl-dev libpcap-dev
msg_ok "Installed Dependencies"

msg_info "Installing OpenCanary"
$STD virtualenv env/
$STD . env/bin/activate
$STD pip install opencanary
msg_info "Installed OpenCanary"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
