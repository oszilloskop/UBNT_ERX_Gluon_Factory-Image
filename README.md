# Gluon auf UBNT EdgeRouter X, EdgeRouter X-SFP und EdgePoint R6
</br>
Mit diesem Projekt kann Gluon sehr einfach über das Web-GUI der UBNT-Stockfirmware auf einen EdgeRouter X geflasht werden.  
</br>
Die folgende Anleitung gilt für die Ubiquiti Router "**EdgeRouter X**", "**EdgeRouter X-SFP**" und "**EdgePoint R6**".  
</br>
Dieses Projekt stellt ein generisches (Community unabhängiges) und in der Größe reduziertes Gluon-Initramfs-Factory-Image bereit.  
Es handelt sich um eine abgespeckte Gluon-Version.  
Das bereitgestellte Gluon-Factory-Image ist für alle drei Router-Typen verwendbar.</br>
</br>
  
EdgeRouter X | EdgeRouter X-SFP | EdgePoint R6
:-------------: | :-------------: | :-------------:
![image](https://wiki.openwrt.org/_media/media/ubiquiti/ubiquiti-edgerouter-x.png?w=300&tok=cd9c12 "ER-X")  | ![image](https://wiki.openwrt.org/_media/media/ubiquiti/ubiquiti-edgerouter-x-sfp.png?w=300&tok=afa2d9 "ER-X-SFP")  | ![image](https://wiki.openwrt.org/_media/media/ubiquiti/ubiquiti_edgepoint_r6_ep-r6.png?w=149&tok=74cc15 "EP-R6")
Anmerkung:  
Der EdgePoint R6 ist von der Hardware identisch zum EdgeRouter X-SFP

## UBNT EdgeRouter X und Gluon
Beim dem Bauen der Gluon-Firmware (aktuell 2017.1.x) fällt aus Router-technischen Gründen kein Factory-Image für die UBNT-EdgeRouter X heraus. Daher muss man bisher auf die [interne serielle Schnittstelle des Routers](http://sector5d.org/openwrt-on-the-ubiquiti-edgerouter-x.html) zurückgreifen, oder sich mit einem [Lede-Initramfs-Factory-Image](https://www.freifunk-winterberg.net/die-nutzung-von-ubiquiti-edgerouter-x-als-freifunk-offloader/) über die Stockfirme-Konsole aushelfen. Es ist auf jeden Fall immer eine Mehrphasiges Vorgehen notwendig.  

Folgend wird eine weitere, aber deutlich einfachere Flash-Möglichkeit beschrieben. Gluon kann direkt über das Web-GUI der UBNT-Stockfirmware auf einen EdgeRouter X geflasht werden. Die Prozedur ist weiterhin mehrphasig.  
Die hier downloadbare Factory-Firmware bietet dem Nutzer lediglich die Möglichkeit, im Gluon-Web-Konfigmodus ein Sysupgrade durchzuführen (ansonsten ist die sie funktionslos). Mit dem Sysupgrade kann dann die Community-spezifische Gluon-Firmeware auf den EdgeRouter X geflasht werden.

![](https://upimg.de/img/bildschirmfoto2_0ywtzy.png)
# Gluon flashen
## Phase 1 - Gluon-Factory über UBNT Web-GUI
- Ein neuer EdgeRouter X hat die feste IP 192.168.1.1, es läuft kein DHCP auf dem Router.  
- Ein zu verbindender PC muss daher mit einer statischen IP konfiguriert werden (z.B. 192.168.1.20).  
- Der EdgeRouter X muß über den eth0-Port (WAN) mit dem PC verbunden werden.  
- Der EdgeRouter X ist nun über https://192.168.1.1 zu erreichen .  
- Nach dem Login (Benutzer: "ubnt", Passwort: "ubnt"), dann unten links auf 'System' klicken. 
- Im Fenster runterscrollen und bei "Upgrade System Image" das Image "__gluon-ramips-mt7621-ubnt-erx-initramfs-factory.tar__" (aus diesem Projekt) verwenden.
- Den Anweisungen folgen (inkl. Reboot).
- Weiter mit Phase 2

## Phase 2 - Gluon-Sysupgrade über die Gluon-Konfigmodus
- Der EdgeRouter X muß nun über einen Port eth1-4 (LAN) mit dem PC verbunden werden.
- PC wieder so konfigurieren, dass er seine IP per DHCP erhält.
- Nach dem Booten des EdgeRouters ist die Gluon-Konfigseite über http://192.168.1.1 zu erreichen.
- Evtl. den Browser-Cache, -Verlauf, etc. löschen. Es kann sonst zu Browser-Problemen wegen des vorherigen http**s**-Zugriffs auf 192.168.1.1 kommen.
- Nun im Gluon-Konfigmodus ein Sysupgrade mit einem Image eurer Community durchführen.
- Weiter mit Phase 3

## Pahse 3 - Einrichten eurer Community-Firmware
- Nach dem Booten sollte über http://192.168.1.1 die Gluon-Konfigseite eurer Community-Firmware angezeigt werden.

Done!


# ERX Factory-Image selberbauen
folgt
# Per Konsole zurück zur UBNT Stockfirmware
folgt