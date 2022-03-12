curl -fsSL https://toolbelt.treasuredata.com/sh/install-ubuntu-focal-td-agent4.sh | sh
# modify /etc/td-agent/td-agent.conf
systemctl restart td-agent
