interface bridge add
interface bridge port add interface=ether1 bridge=bridge1
interface bridge port add interface=ether2 bridge=bridge1
ip add add interface=bridge1 address=172.20.0.1/30

routing bgp instance set 0 as=266054
routing bgp peer add remote-address=172.20.0.2 remote-as=265138


routing bgp network add network=45.4.43.0/24

ip route add type=blackhole dst-address=45.4.43.0/24



ip add add interface=ether1 address=172.20.0.2/30

routing bgp instance set 0 as=265138
routing bgp peer add remote-address=172.20.0.1 remote-as=266054


routing bgp network add network=143.208.72.0/22 
routing bgp network add network=143.208.72.0/23
routing bgp network add network=143.208.74.0/23
routing bgp network add network=143.208.72.0/24
routing bgp network add network=143.208.73.0/24
routing bgp network add network=143.208.74.0/24
routing bgp network add network=143.208.75.0/24

ip route add type=blackhole dst-address=143.208.72.0/22
ip route add type=blackhole dst-address=143.208.72.0/23
ip route add type=blackhole dst-address=143.208.74.0/23
ip route add type=blackhole dst-address=143.208.72.0/24
ip route add type=blackhole dst-address=143.208.73.0/24
ip route add type=blackhole dst-address=143.208.74.0/24
ip route add type=blackhole dst-address=143.208.75.0/24