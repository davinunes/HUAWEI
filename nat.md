

#================================================================================================


acl number 3001
    rule 1 permit ip source 100.100.0.0   0.0.3.255
#

acl number 3002
    rule 1 permit ip source 100.100.4.0   0.0.3.255
#

acl number 3003
    rule 1 permit ip source 100.100.8.0   0.0.3.255
#

acl number 3004
    rule 1 permit ip source 100.100.12.0   0.0.3.255
#


service-location 1
 location follow-forwarding-mode
#
service-instance-group SIG-NAT-1
 service-location 1
#



#    45.255.156.224/27
#    45.255.157.224/27
#    45.255.158.96/27
#    45.255.159.96/27

nat instance NAT-INST-01 id 1
    service-instance-group SIG-NAT-1
    nat address-group NAT-ADDRG-01 group-id 1 
        section 1 45.255.156.224 mask 27
#
nat instance NAT-INST-02 id 2
    service-instance-group SIG-NAT-1
    nat address-group NAT-ADDRG-01 group-id 1 
        section 1 45.255.157.224 mask 27
#
nat instance NAT-INST-03 id 3
    service-instance-group SIG-NAT-1
    nat address-group NAT-ADDRG-01 group-id 1 
        section 1 45.255.158.96 mask 27
#
nat instance NAT-INST-04 id 4
    service-instance-group SIG-NAT-1
    nat address-group NAT-ADDRG-01 group-id 1 
        section 1 45.255.159.96 mask 27
#


interface GigabitEthernet0/5/7
    description CGN-TO-VS01-BG
    ip address 10.109.11.2 255.255.255.252
    statistic enable
    nat bind acl 3001 instance NAT-INST-01 precedence 0
    nat bind acl 3002 instance NAT-INST-02 precedence 1
    nat bind acl 3003 instance NAT-INST-03 precedence 2
    nat bind acl 3004 instance NAT-INST-04 precedence 3
#

