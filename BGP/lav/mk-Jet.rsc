interface bridge add
interface bridge port add interface=ether1 bridge=bridge1
interface bridge port add interface=ether2 bridge=bridge1
ip add add interface=bridge1 address=172.31.21.13/30

routing bgp instance set 0 as=263558
routing bgp peer add remote-address=172.31.21.14 remote-as=265138

routing bgp network add network=143.255.196.0/22


ip route add type=blackhole dst-address=143.255.196.0/22


ip add add interface=ether4 address=172.31.21.14/30

routing bgp instance set 0 as=265138
routing bgp peer add remote-address=172.31.21.13 remote-as=263558
