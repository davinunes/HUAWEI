
# Configurar Huawei MA5800-X7 2

Acessando pelo terminal serial, logue como root, a senha padrão de root é  admin123

```
enable
config
display board 0
board confirm 0/1
```

```

vlan 3049 standard
 port vlan 3049 0/8 0
 port vlan 3049 0/8 1
 q
```

```
interface mpu 0/8
 auto-neg 1 disable
 q
```

```
interface Vlanif3049
 ip address 10.169.64.6 255.255.255.252 description "gerencia"
 q
```

```
ip route-static 0.0.0.0 0.0.0.0 10.169.64.5 description "default"
```

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

terminal user name ilunne
[Segue o assistente]

```
 ssh user "ilunne" authentication-type all
 ssh user "ilunne" assign rsa-key "kilunne"
```

```
sysman server source ssh any-interface
```