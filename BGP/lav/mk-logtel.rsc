interface bridge add
interface bridge port add interface=ether1 bridge=bridge1
interface bridge port add interface=ether2 bridge=bridge1
ip add add interface=bridge1 address=10.10.0.17/30

routing bgp instance set 0 as=53195
routing bgp peer add remote-address=10.10.0.18 remote-as=265138


routing bgp network add network=187.121.144.0/21
routing bgp network add network=187.121.145.0/24
routing bgp network add network=187.121.146.0/24

routing bgp network add network=201.87.240.0/20
routing bgp network add network=201.87.241.0/24
routing bgp network add network=201.87.242.0/24

ip route add type=blackhole dst-address=187.121.144.0/21
ip route add type=blackhole dst-address=201.87.240.0/20
ip route add type=blackhole dst-address=187.121.145.0/24
ip route add type=blackhole dst-address=187.121.146.0/24
ip route add type=blackhole dst-address=201.87.241.0/24
ip route add type=blackhole dst-address=201.87.242.0/24



ip add add interface=ether7 address=10.10.0.18/30

routing bgp instance set 0 as=265138
routing bgp peer add remote-address=10.10.0.17 remote-as=53195
