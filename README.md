# Configurando acesso SSH

Pra deixar tudo acessível

```
local-aaa-server
#
user-interface maximum-vty 21
user-interface vty 0 4
acl 2001 inbound
authentication-mode aaa
y
idle-timeout 35791 0
user privilege level 3
protocol inbound all
shell
#
acl number 2001
description Limita_SSH
rule 10 permit source 10.0.0.0 0.255.255.255
rule 20 permit source 172.0.0.0 0.63.255.255
rule 30 permit source 192.168.0.0 0.0.255.255
rule 40 permit source 143.208.72.0 0.0.3.255
#

stelnet server enable
ssh ipv4 server port 1822
ssh ipv6 server port 1822
ssh server ip-block disable
ssh authentication-type default password
ssh server-source all-interface
y
ssh ipv6 server-source all-interface
y

#
ssh server acl 2001
ssh server cipher aes256_gcm aes128_gcm aes256_ctr aes192_ctr aes128_ctr
ssh server hmac sha2_512 sha2_256
ssh server key-exchange dh_group_exchange_sha256 dh_group_exchange_sha1 dh_group14_sha1 ecdh_sha2_nistp256 ecdh_sha2_nistp384 ecdh_sha2_nistp521
#
ssh server publickey ecc rsa
#
ssh server dh-exchange min-len 2048
#
ssh client publickey ecc rsa
#
ssh client cipher aes256_gcm aes128_gcm aes256_ctr aes192_ctr aes128_ctr
ssh client hmac sha2_512 sha2_256
ssh client key-exchange dh_group_exchange_sha256 dh_group_exchange_sha1 dh_group14_sha1 ecdh_sha2_nistp256 ecdh_sha2_nistp384 ecdh_sha2_nistp521
#

ssh user ilunne
ssh user ilunne authentication-type all
ssh user ilunne service-type all

#
aaa
local-user ilunne password irreversible-cipher MinhaSuperSenha@131377
local-user ilunne level 3
local-user ilunne service-type ssh ftp http telnet
#



commit
run save
y

rsa peer-public-key kilunne encoding-type openssh
 public-key-code begin
  ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAuC+NFPDqI8IGtAm3AfipAUfd1dNa9so5kpyvEyXCFp                                                                                                                                                                                                                                      VP
  BkeCNO0UACVWRYhaddPEH/ixfw7RNSFjyJGuAlc58P9po9jkwkhRomQBqfW/K5zF7k6hTUW2xj4yfd                                                                                                                                                                                                                                      d9
  BksmcZ5QG4x741F8no4FZWFb5nrDxwE3nz8SlbE9h6d8DfryJwlhvO7TBMWo5xneXhBHFYq5f8OUlu                                                                                                                                                                                                                                      qO
  ew/0+cbNp0L55XAH7dRqX8js54K3WfFWBs2QHVLWnQzEW2wEfmeXnu5WjagDeiWU2DU6OXFEp5FZc+                                                                                                                                                                                                                                      r5
  wjxeEzKfeWJTRgUJAHL9RWLfQnb8nMKLch8Q5zYj9g3BH/bB/c28jV3d8w== rsa-key
 public-key-code end
 peer-public-key end
#
ssh user ilunne assign rsa-key kilunne

commit
run save
y
```
Comunicação Inter-VS

```
#=================================================================== N8000 - Parte 2 - Criar VS e inter-vs veth




#-------------------------------------------- VETH L2


interface Virtual-Ethernet0/2/2
 ve-group 2 l2-terminate
#


interface Virtual-Ethernet0/3/3
 ve-group 3 l2-terminate
#


#-------------------------------------------- VETH L3


interface Virtual-Ethernet0/2/21
 ve-group 2 l3-access
 mac-address c4b8-cafe-ee21
#

interface Virtual-Ethernet0/3/31
 ve-group 3 l3-access
 mac-address c4b8-cafe-ee31
#


#-------------------------------------------- VETH VLANS [A]


interface Virtual-Ethernet0/2/2.1001
 vlan-type dot1q 1001
 statistic enable
#

interface Virtual-Ethernet0/2/2.1002
 vlan-type dot1q 1002
 statistic enable
#

interface Virtual-Ethernet0/2/2.1003
 vlan-type dot1q 1003
 statistic enable
#

#-------------------------------------------- VETH VLANS [B]


interface Virtual-Ethernet0/3/3.1001
 vlan-type dot1q 1001
 statistic enable
#

interface Virtual-Ethernet0/3/3.1002
 vlan-type dot1q 1002
 statistic enable
#

interface Virtual-Ethernet0/3/3.1003
 vlan-type dot1q 1003
 statistic enable
#

#-------------------------------------------- CCC entre VLANS VETH


ccc p2p-1001 interface Virtual-Ethernet0/2/2.1001 tagged out-interface Virtual-Ethernet0/3/3.1001 tagged
ccc p2p-1002 interface Virtual-Ethernet0/2/2.1002 tagged out-interface Virtual-Ethernet0/3/3.1002 tagged
ccc p2p-1003 interface Virtual-Ethernet0/2/2.1003 tagged out-interface Virtual-Ethernet0/3/3.1003 tagged


#-------------------------------------------- VETH VLANS L3 para VSs


interface Virtual-Ethernet0/2/21.1001
 vlan-type dot1q 1001
#
interface Virtual-Ethernet0/2/21.1002
 vlan-type dot1q 1002
#
interface Virtual-Ethernet0/2/21.1003
 vlan-type dot1q 1003
#


interface Virtual-Ethernet0/3/31.1001
 vlan-type dot1q 1001
#
interface Virtual-Ethernet0/3/31.1002
 vlan-type dot1q 1002
#
interface Virtual-Ethernet0/3/31.1003
 vlan-type dot1q 1003
#


#-------------------------------------------- VETH VLANS L3 - CONFIG - LADO VS-ADMIN


interface Virtual-Ethernet0/2/21.1001
    description Conexao-com-VS-BGP-WAN-PUB-IPv4
    vlan-type dot1q 1001
    ip address 10.77.1.2 255.255.255.252
    statistic enable
#

interface Virtual-Ethernet0/2/21.1002
    description Conexao-com-VS-BGP-WAN-PUB-IPv6
    vlan-type dot1q 1002
    ipv6 enable
    # ipv6 address 2001:db8:2::2/64
    statistic enable
#



#-------------------------------------------- Config interfaces VS-01

assign interface Virtual-Ethernet0/3/31.1001
y
  assign interface Virtual-Ethernet0/3/31.1002
y
  assign interface Virtual-Ethernet0/3/31.1003
y




interface Virtual-Ethernet0/3/31.1001
    description Conexao-com-VS-ADMIN-BRAS-WAN-PUB-IPv4
    vlan-type dot1q 1001
    ip address 10.77.1.1 255.255.255.252
    statistic enable
#

interface Virtual-Ethernet0/3/31.1002
    description Conexao-com-VS-ADMIN-BRAS-WAN-PUB-IPv6
    vlan-type dot1q 1002
    ip address unnumbered interface LoopBack0
    ipv6 enable
    #ipv6 address 2001:db8:2::1/64
    statistic enable
#
```
