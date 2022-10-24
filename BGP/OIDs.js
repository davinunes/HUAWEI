/* OIDs para possiveis Monitoramentos */
"https://support.huawei.com/hedex/hdx.do?docid=EDOC1100168821&tocURL=resources%2Fmib%2Fdc_8090_BGP4-MIB_mibtable_1.3.6.1.2.1.15.3.html&tocLibId=AEJ1214K&tocLibVer=05&ui=1"

/* Peer State:
 */
"1.3.6.1.2.1.15.3.1.2."+{IPV4} // Peer State
/*  1: Desativado
    2: Desconectado {Connect}
    3: Desconectado {Active}
    4: 
    5: 
    6: Perfeito
*/
"1.3.6.1.2.1.15.3.1.1."+{IPV4} // Peer Description (Vai retornar o IP do Peer)
Ex: "1.3.6.1.2.1.15.3.1.2.10.0.0.125"
"1.3.6.1.2.1.15.3.1.9"+{IPV4} // Remote AS

