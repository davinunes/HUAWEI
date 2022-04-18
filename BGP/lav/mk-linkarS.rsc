interface bridge add
interface bridge port add interface=ether1 bridge=bridge1
interface bridge port add interface=ether2 bridge=bridge1
ip add add interface=bridge1 address=45.165.197.141/30

routing bgp instance set 0 as=268689
routing bgp peer add remote-address=45.165.197.142 remote-as=265138

routing bgp network add network=45.165.196.0/22


ip route add type=blackhole dst-address=45.165.196.0/22


ip add add interface=ether5 address=45.165.197.142/30

routing bgp instance set 0 as=265138
routing bgp peer add remote-address=45.165.197.141 remote-as=268689
