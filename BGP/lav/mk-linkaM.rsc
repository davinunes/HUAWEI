interface bridge add
interface bridge port add interface=ether1 bridge=bridge1
interface bridge port add interface=ether2 bridge=bridge1
ip add add interface=bridge1 address=45.165.196.141/30

routing bgp instance set 0 as=268689
routing bgp peer add remote-address=45.165.196.142 remote-as=265138

routing bgp network add network=45.165.196.0/22
routing bgp network add network=1.1.1.0/24
routing bgp network add network=2.1.1.0/24
routing bgp network add network=3.1.1.0/24
routing bgp network add network=4.1.1.0/24
routing bgp network add network=5.1.1.0/24
routing bgp network add network=6.1.1.0/24
routing bgp network add network=7.1.1.0/24
routing bgp network add network=8.1.1.0/24
routing bgp network add network=9.1.1.0/24


ip route add type=blackhole dst-address=45.165.196.0/22
ip route add type=blackhole dst-address=1.1.1.0/24
ip route add type=blackhole dst-address=2.1.1.0/24
ip route add type=blackhole dst-address=3.1.1.0/24
ip route add type=blackhole dst-address=4.1.1.0/24
ip route add type=blackhole dst-address=5.1.1.0/24
ip route add type=blackhole dst-address=6.1.1.0/24
ip route add type=blackhole dst-address=7.1.1.0/24
ip route add type=blackhole dst-address=8.1.1.0/24
ip route add type=blackhole dst-address=9.1.1.0/24


ip add add interface=ether6 address=45.165.196.142/30

routing bgp instance set 0 as=265138
routing bgp peer add remote-address=45.165.196.141 remote-as=268689
