
# Configurar Huawei MA5800-X7 2

Acessando pelo terminal serial, logue como root, a senha padrão de root é  admin123

```
enable
config
```
Habilitar as placas
```
display board 0
board confirm 0/1
```
Criar a Vlan de Gerencia
```

vlan 3049 standard
 port vlan 3049 0/8 0
 port vlan 3049 0/8 1
 q
```
Pode ser necessário ajustar a auto negociação
```
interface mpu 0/8
 auto-neg 1 disable
 q
```
Setar IP de gerencia
```
interface Vlanif3049
 ip address 10.169.64.6 255.255.255.252 description "gerencia"
 q
```
E a rota padrão
```
ip route-static 0.0.0.0 0.0.0.0 10.169.64.5 description "default"
```
Adicionar a chave rsa
```
rsa peer-public-key "kilunne" encoding-type openssh
 public-key-code begin
  ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAuC+NFPDqI8IGtAm3AfipAUfd1dNa9so5kpyvEyXCFpVP
  BkeCNO0UACVWRYhaddPEH/ixfw7RNSFjyJGuAlc58P9po9jkwkhRomQBqfW/K5zF7k6hTUW2xj4yfdd9
  BksmcZ5QG4x741F8no4FZWFb5nrDxwE3nz8SlbE9h6d8DfryJwlhvO7TBMWo5xneXhBHFYq5f8OUluqO
  ew/0+cbNp0L55XAH7dRqX8js54K3WfFWBs2QHVLWnQzEW2wEfmeXnu5WjagDeiWU2DU6OXFEp5FZc+r5
  wjxeEzKfeWJTRgUJAHL9RWLfQnb8nMKLch8Q5zYj9g3BH/bB/c28jV3d8w== rsa-key
 public-key-code end
 peer-public-key end
```
Cria um usuario
```
terminal user name ilunne
```
> [Segue o assistente]

Define o tipo de autenticação do usuario e atribui a chave rsa
```
config
 ssh user "ilunne" authentication-type all
 ssh user "ilunne" assign rsa-key "kilunne"
```

Coloca a interface pra ouvir o SSH
```
sysman server source ssh any-interface
```

Habilitar Telnet para integração com IXC:

```
sysman server source telnet any-interface
sysman service telnet enable
```
Verificar:

Criar vlan smart

```
vlan 3050 smart
port vlan 3050 0/8 0
```

dba profile (upload)
```
dba-profile add profile-id 100 profile-name "P-1G-UP" type3 assure 7168 max 10000000
```
trafic table (download)
```bash
traffic table ip index 100 cir 7168 pir 10000000 priority 4 priority-policy tag-in-package 
```
srv-profile

```
ont-srvprofile gpon profile-id 3050 profile-name "vlan3050"
ont-port pots adaptive 32 eth adaptive 8
port vlan eth 1 translation 3050 user-vlan 3050
  port vlan eth 2 translation 3050 user-vlan 3050
  port vlan eth 3 translation 3050 user-vlan 3050
  port vlan eth 4 translation 3050 user-vlan 3050
  q
```

line profile

```
ont-lineprofile gpon profile-id 3050 profile-name "vlan3050"
tcont 1 dba-profile-id 100
gem add 1 eth tcont 1
gem mapping 1 1 vlan 3050
q
```

ativar portas pon

```
interface gpon 0/1
 port 0 ont-auto-find enable
 port 1 ont-auto-find enable
 port 2 ont-auto-find enable
 port 3 ont-auto-find enable
 port 4 ont-auto-find enable
 port 5 ont-auto-find enable
 port 6 ont-auto-find enable
 port 7 ont-auto-find enable
 port 8 ont-auto-find enable
 port 9 ont-auto-find enable
 port 10 ont-auto-find enable
 port 11 ont-auto-find enable
 port 12 ont-auto-find enable
 port 13 ont-auto-find enable
 port 14 ont-auto-find enable
 port 15 ont-auto-find enable
```

provisonar onu

```
interface gpon #subrack#/#slot#;
ont add #pon# sn-auth #onu_mac# omci ont-lineprofile-id #vlan# ont-srvprofile-id #vlan# desc #nome#;
ont port native-vlan #pon# #onu_numero# eth 1 vlan #vlan# priority 0;
quit;
service-port vlan #vlan# gpon #pon_id# ont #onu_numero# gemport 1 multi-service user-vlan #vlan#;
```





