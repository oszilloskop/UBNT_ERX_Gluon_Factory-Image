# Gluon auf UBNT EdgeRouter X und EdgeRouter X-SFP
  
Mit Hilfe dieses Projektes kann ein EdgeRouter X sehr einfach über das Web-GUI der UBNT-Stockfirmware in einen Gluon-Router umgeflasht werden.  
  
Weiterhin wird beschrieben, wie über die Konsole ein EdgeRouter X mit einer bereits aufgespielten Gluon- oder Lede-Firmware auf die UBNT-Stockfirmware zurückgeflasht werden kann.  
  
Die folgende Anleitung gilt für die Ubiquiti Router ER-X und ER-X-SFP:
  
  
EdgeRouter X | EdgeRouter X-SFP
:-------------: | :-------------:
![image](https://wiki.openwrt.org/_media/media/ubiquiti/ubiquiti-edgerouter-x.png?w=300&tok=cd9c12 "ER-X")  | ![image](https://wiki.openwrt.org/_media/media/ubiquiti/ubiquiti-edgerouter-x-sfp.png?w=300&tok=afa2d9 "ER-X-SFP")
  
</br>

Dieses Projekt stellt generische (Community-unabhängige) Gluon-initramfs-Factory-Images bereit.  
Es handelt sich bei den Images um eine abgespeckte Gluon-Version.  
</br>

---

## UBNT EdgeRouter X und Gluon
Beim dem Bauen der Gluon-Firmware (aktuell 2017.1.x) fällt aus Router-technischen Gründen kein Factory-Image für den UBNT-EdgeRouter X heraus. Wenn Gluon auf einen EdgeRouter X aufgespielt werden soll, dann muss man bisher auf die [interne serielle Schnittstelle des Routers](http://sector5d.org/openwrt-on-the-ubiquiti-edgerouter-x.html) zurückgreifen, oder man muß sich mit einem [generischen Lede-Image](https://www.freifunk-winterberg.net/die-nutzung-von-ubiquiti-edgerouter-x-als-freifunk-offloader/) aushelfen. Es ist auf jeden Fall immer ein mehrphasiges Vorgehen inkl. Konsolennutzung notwendig.  

### Neuer Lösungsansatz
Folgend wird eine weitere, aber deutlich einfachere Flash-Möglichkeit beschrieben. Ein Community-spezifisches Gluon kann über den Weg des Web-GUI der UBNT-Stockfirmware auf einen EdgeRouter X geflasht werden. Die Prozedur ist mehrphasig.  
  
Die hier downloadbaren generischen Gluon-Factory-Images bieten dem Nutzer die Möglichkeit, über die Gluon-Web-Konfigseite ein Sysupgrade des Routers durchzuführen (ansonsten ist sie funktionslos).  
  
Mit dem Sysupgrade kann dann ein Gluon-Sysupgrade-Image einer beliebigen Community auf den EdgeRouter X geflasht werden.  
  
![](https://upimg.de/img/bildschirmfoto2_0ywtzy.png)  

---

</br>

# Los geht's: Gluon auf EdgeRouter X flashen
Wenn ein EdgeRouter X auf Gluon umgeflasht werde soll, dann wird folgendes benötigt:
- Ein hier bereitgestelltes Gluon-initramfs-Factory-Image:
    - Für einen EdgeRouter X: [gluon-ramips-mt7621-ubnt-erx-initramfs-factory.tar](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/blob/master/gluon-ramips-mt7621-ubnt-erx-initramfs-factory.tar)
    - Für einen EdgeRouter X-SFP: [gluon-ramips-mt7621-ubnt-erx-sfp-initramfs-factory.tar](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/blob/master/gluon-ramips-mt7621-ubnt-erx-sfp-initramfs-factory.tar) 
- Ein Community-spezifisches Gluon-Sysupgrade-Image für einen EdgeRouter X, EdgeRouter X-SFP  

## Phase 1 -> Gluon-Factory über das UBNT Web-GUI
- Ein neuer EdgeRouter X hat die feste IP 192.168.1.1, es läuft kein DHCP auf dem Router.  
- Der EdgeRouter X muß über den eth0-Port (WAN) mit einem PC verbunden werden.
- Der verbundendene PC muss mit einer passenden statischen IP konfiguriert werden (z.B. 192.168.1.20).    
- Der EdgeRouter X ist nun über [https://192.168.1.1/](https://192.168.1.1/) zu erreichen.  
- Nach dem Login (Benutzer: "ubnt", Passwort: "ubnt") dann unten links auf 'System' klicken. 
- Im Fenster runterscrollen und bei "Upgrade System Image" das Image `gluon-ramips-mt7621-ubnt-erx-initramfs-factory.tar` verwenden.
- Den Anweisungen folgen (inkl. Reboot).
- Weiter mit Phase 2

## Phase 2 -> Gluon-Sysupgrade über die Gluon-Konfigseite
- Nach dem Booten des EdgeRouters ist die Gluon-Konfigseite per Web-Browser über [http://192.168.1.1/](http://192.168.1.1/) zu ereichen.
- Der EdgeRouter X muß nun über einen der Ports eth1-4 (LAN) mit dem PC verbunden werden.
- Den PC ggf. wieder so konfigurieren, dass er seine IP per DHCP erhält.
- Evtl. den Browser-Cache, -Verlauf, etc. löschen. Es kann sonst zu Browser-Problemen wegen des vorherigen http**s**-Zugriffs auf 192.168.1.1 kommen.
- Nun über die Gluon-Konfigseite ein Sysupgrade mit einem Image einer beliebigen Community durchführen.
- Weiter mit Phase 3

## Phase 3 -> Einrichten der eigenen Community-Firmware
- Nach dem Booten sollte über [http://192.168.1.1/](http://192.168.1.1/) die Gluon-Konfigseite der Community-spezifischen Firmware angezeigt werden.

Done!

---

# Per Konsole zurück zur UBNT-Stockfirmware
Gute Nachrichten:  
Ein EdgeRouter X mit einer bereits aufgespielten Gluon- oder Lede-Firmware läßt sich sehr einfach über die Konsole auf die original UBNT-Stockfrimware zurückflashen.  
  
  
Bei diesem Projekt fällt auch ein initramfs-Kernel ab. Der EdgeRouter X kann mit Hilfe der folgenden Anleitung überredet werden, diesen Kernel beim Booten zu laden. Danach liegt ein Gluon-System vor, welches vollständig im RAM abläuft (der Kernel, wie auch das Filesystem). Dadurch wird der Flash-Speicher von der laufenden Firmware nicht eingebunden und die UBNT-Stockfirmware kann dort ohne Probleme abgespeichert werden. Die Prozedur ist mehrphasig.  
  
Wenn ein Gluon- oder Lede-EdgeRouter zurück auf die UBNT-Stockfirmware geflasht werde soll, dann wird folgendes benötigt:
- Ein hier bereitgestelltes "Back to Stock"-initramfs-Binary
   - Für einen EdgeRouter X: [back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/blob/master/back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin)
   - Für einen EdgeRouter X-SFP: [back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/blob/master/back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin) 
- Eine original UBNT Stockfirmware für den EdgeRouter X, EdgeRouter X-SFP: [https://www.ubnt.com/download/edgemax/edgerouter-x](https://www.ubnt.com/download/edgemax/edgerouter-x)

## Phase 1 -> Flashen des initramfs-Binaries
- Das "Back to Stock"-initramfs-Binary irgendwie auf den umzuflashenden Gluon- bzw. Lede-EdgeRouter in den Ordner `/tmp` transferieren (z.B. mit "scp").
- Mit dem umzuflashenden Gluon- bzw. Lede-EdgeRouter per SSH verbinden.
- Auf der Router-Konsole wird mit folgenden Befehlen das "Back to Stock"-initramfs-Binary in die Kernel-Flash-Partitionen "mtdblock3" und "mtdblock4" übertragen:  
    - Bei einem EdgeRouter X das hier verwenden:  
    ```
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin of=/dev/mtdblock3
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin of=/dev/mtdblock4
    ```
    - Bei einem EdgeRouter X-SFP das hier verwenden:  
    ```
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin of=/dev/mtdblock3
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin of=/dev/mtdblock4
    ```
- Mit `'reboot'` den EdgeRouter X neu starten.
- Weiter mit Phase 2

## Phase 2 -> Flashen der UBNT-Stockfirmware
- Der EdgeRouter X muß über einen der Ports eth1-4 (LAN) mit dem PC verbunden werden.
- Den PC ggf. so konfigurieren, dass er seine IP per DHCP erhält.
- Nach dem Booten mittels '`ssh root@192.168.1.1`' auf dem EdgeRouters X einloggen.
- Die UBNT-Stockfirmware auf dem PC lokal entpacken und die Dateien `version.tmp, squashfs.tmp, squashfs.tmp.md5, und vmlinux.tmp` irgendwie auf den umzuflashenden EdgeRouter X in den Ordner `/tmp` transferieren (z.B. mit "scp").
- **Bitte wirklich /tmp als Zielpfad verwenden. Ansonsten können die folgenden Befehlsfolgen zu einem Brick des Routers führen!**
- Auf der Router-Konsole wird mit folgenden Befehlen die UBNT-Stockfirmware auf den EdgeRouters X geflasht:  
```
ubidetach -p /dev/mtd5
ubiformat /dev/mtd5
ubiattach -p /dev/mtd5
ubimkvol /dev/ubi0 --vol_id=0 --lebs=1925 --name=troot
mount -o sync -t ubifs ubi0:troot /mnt/
cp /tmp/version.tmp /mnt/version
cp /tmp/squashfs.tmp /mnt/squashfs.img              # <- Das kann 1-2 Minuten dauern...
cp /tmp/squashfs.tmp.md5 /mnt/squashfs.img.md5

dd if=/tmp/vmlinux.tmp of=/dev/mtdblock3
dd if=/tmp/vmlinux.tmp of=/dev/mtdblock4
```
- Mit `'reboot'` den EdgeRouter X neu starten.
- Weiter mit Phase 3

## Phase 3 -> Einrichten der UBNT-Stockfirmware
- Ein neuer EdgeRouter X hat die feste IP 192.168.1.1, es läuft kein DHCP auf dem Router.  
- Der EdgeRouter X muß über den eth0-Port (WAN) mit einem PC verbunden werden.  
- Der verbundene PC muss mit einer passenden statischen IP konfiguriert werden (z.B. 192.168.1.20).  
- Das UBNT Web-GUI ist nach dem Booten und nach ca. 2 Minuten per Web-Browser über [https://192.168.1.1/](https://192.168.1.1/) zu erreichen.  
- Evtl. den Browser-Cache, -Verlauf, etc. löschen. Es kann sonst zu Browser-Problemen wegen der vorherigen http / http**s**-Zugriffe auf 192.168.1.1 kommen.
- Nach dem Anmelden (Benutzer: "ubnt", Passwort: "ubnt") dann unten links auf 'System' klicken.
- Den EdgeRouter X nach Belieben konfigurieren.

Done!  

---

# ERX Factory-Image selberbauen
folgt  

---

# Interessante Links
- [UBNT: Quickstart Guide EdgeRouter X](https://dl.ubnt.com/guides/edgemax/EdgeRouter_ER-X_QSG.pdf)
- [OpenWRT Wiki: Ubiquiti EdgeRouter X (ER-X), EdgeRouter X-SFP (ER-X-SFP) and EdgePoint R6 (EP-R6)](https://wiki.openwrt.org/toh/ubiquiti/ubiquiti_edgerouter_x_er-x_ka) 
- [FF-Wintergerg: Die Nutzung von Ubiquiti EdgeRouter-X als Freifunk Offloader](https://www.freifunk-winterberg.net/die-nutzung-von-ubiquiti-edgerouter-x-als-freifunk-offloader)
- [ERX, ERX-SFP System Recovery per serieller Schnittstelle und TFTP](https://community.ubnt.com/t5/EdgeMAX/ERX-ERX-SFP-System-Recovery/td-p/2056921) 
- [Sector5D-Blog: OpenWRT on the Ubiquiti EdgeRouter X](http://sector5d.org/openwrt-on-the-ubiquiti-edgerouter-x.html)
- [UBNT: Downloadseite der original UBNT-Stockfirmware für EdgeRouter X, EdgeRouter X-SF](https://www.ubnt.com/download/edgemax/edgerouter-x)
