aws configure set default.region $(curl -s http://169.254.169.254/latest/meta-data/placement/region)
mkfs -t xfs /dev/nvme2n1
mkdir -p /var/lib/rancher
mount /dev/nvme2n1 /var/lib/rancher
mkdir -p /var/lib/rancher/rke2
mkdir -p /var/lib/rancher/kubelet
ln -s /var/lib/rancher/kubelet /var/lib/kubelet
iptables -A INPUT -p tcp -m tcp --dport 2379 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 2380 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 9345 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 6443 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 8472 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 10250 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 30000:32767 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 4240 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 179 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 4789 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 5473 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 9098 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 9099 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 51820 -m state --state NEW -j ACCEPT
iptables -A INPUT -p udp -m udp --dport 51821 -m state --state NEW -j ACCEPT
iptables -A INPUT -p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type 0 -m state --state ESTABLISHED,RELATED -j ACCEPT
service iptables save
sysctl -w vm.max_map_count=524288
echo "vm.max_map_count=524288" > /etc/sysctl.d/vm-max_map_count.conf
sysctl -w fs.nr_open=13181252
echo "fs.nr_open=13181252" > /etc/sysctl.d/fs-nr_open.conf
sysctl -w fs.file-max=13181250
echo "fs.file-max=13181250" > /etc/sysctl.d/fs-file-max.conf
echo "* soft nofile 13181250" >> /etc/security/limits.d/ulimits.conf
echo "* hard nofile 13181250" >> /etc/security/limits.d/ulimits.conf
echo "* soft nproc  13181250" >> /etc/security/limits.d/ulimits.conf
echo "* hard nproc  13181250" >> /etc/security/limits.d/ulimits.conf
sysctl -p
modprobe xt_REDIRECT
modprobe xt_owner
modprobe xt_statistic
printf "xt_REDIRECT\nxt_owner\nxt_statistic\n" | sudo tee -a /etc/modules