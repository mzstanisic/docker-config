<#
WOL Setup
--------------------------------------------------------

-- Windows desktop setup
1. Install WakeMeOnLan with 'winget install NirSoft.WakeMeOnLan'
2. Find server's network device MAC address 

-- Proxmox server setup
1. Turn on WOL in BIOS
2. Boot into Proxmox
3. Enter the host's console
4. Find the network device with 'ip addr' -> enp2s0
5. Check Wake-on status is 'g' with 'ethtool enp2s0'
6. Set it to 'g' with 'ethtool -s enp2s0 wol g'
7. To keep it persistent through reboots, edit file
   'nano /etc/systemd/system/wol.service' with this:

[Unit]
Description=Enable Wake-on-LAN
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/ethtool -s enp2s0 wol g

[Install]
WantedBy=multi-user.target

8. Enable the service with 'systemctl enable wol.service'
9. Start the service with 'systemctl start wol.service'
#>
wakemeonlan /wakeup B0:4F:13:0A:E7:02