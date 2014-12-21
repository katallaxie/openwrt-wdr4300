# Block 'friendly-scanner' AKA sipvicious
iptables -I input_wan_rule -p udp --dport 5060 -m string --string "friendly-scanner" --algo bm -j DROP

# iptables -t mangle -I POSTROUTING -p tcp -m tcp --sport 22 -j DSCP --set-dscp-class cs3

# Rate limit registrations to keep us from getting hammered on
iptables -I input_wan_rule -m string --string "REGISTER sip:" --algo bm --to 65 -m hashlimit --hashlimit 4/minute --hashlimit-burst 1 --hashlimit-mode srcip,dstport --hashlimit-name sip_r_limit -j ACCEPT

# Asterisk ports internal SIP profile
iptables -I input_wan_rule -p udp -m udp --dport 5060 -j ACCEPT
iptables -I input_wan_rule -p tcp -m tcp --dport 5060 -j ACCEPT
