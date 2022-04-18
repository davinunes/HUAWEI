interface bridge add
interface bridge port add interface=ether1 bridge=bridge1
interface bridge port add interface=ether2 bridge=bridge1
ip add add interface=bridge1 address=10.168.52.2/30

routing bgp instance set 0 as=268728
routing bgp peer add remote-address=10.168.52.1 remote-as=265138

routing bgp network add network=45.171.192.0/22

ip route add type=blackhole dst-address=45.171.192.0/22


ip add add interface=ether3 address=10.168.52.1/30

routing bgp instance set 0 as=265138
routing bgp peer add remote-address=10.168.52.2 remote-as=268728
