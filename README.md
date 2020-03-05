# Achtung! Achtung!
## Bitte die Images bzw. Verfahren dieses Projektes "erstmal" nicht mehr verwenden!
## Mit Gluon v2020.1 gab es einen Wechsel des NAND-Flash-Handlings bei Ubiquiti EdgeRouter-X bzw. X-SFP.
## Falls kaputte Flash-Speicherzellen vorhanden sind, welche bisher keine Probleme bereiteten, so kann nun ein Sysupgrade auf Gluon v2020.x das Gerät bricken!
## Siehe dazu auch das Gluon-Issue #1937, https://github.com/freifunk-gluon/gluon/issues/1937


# Gluon auf UBNT EdgeRouter X und X-SFP
  
Mit Hilfe dieses Projektes kann ein EdgeRouter X sehr einfach über das Web-GUI der UBNT-Stockfirmware in einen Gluon-Router umgeflasht werden.  
  
Weiterhin wird beschrieben, wie über die Konsole ein EdgeRouter X mit einer bereits aufgespielten Gluon- oder OpenWrt-Firmware auf die UBNT-Stockfirmware zurückgeflasht werden kann.  
  
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
Bei dem Bauen der Gluon-Firmware (aktuell 2018.2.1) fällt aus Router-technischen Gründen kein Factory-Image für den UBNT-EdgeRouter X heraus. Wenn Gluon auf einen EdgeRouter X aufgespielt werden soll, dann muss man bisher auf die [interne serielle Schnittstelle des Routers](http://sector5d.org/openwrt-on-the-ubiquiti-edgerouter-x.html) zurückgreifen, oder man muß sich mit einem [generischen Lede-Image](https://www.freifunk-winterberg.net/die-nutzung-von-ubiquiti-edgerouter-x-als-freifunk-offloader/) aushelfen. Es ist auf jeden Fall immer ein mehrphasiges Vorgehen inkl. Konsolennutzung notwendig.  

### Neuer Lösungsansatz
Folgend wird eine weitere, aber deutlich einfachere Flash-Möglichkeit beschrieben. Ein Community-spezifisches Gluon kann indirekt über den Weg des Web-GUI der UBNT-Stockfirmware auf einen EdgeRouter X geflasht werden. Die Prozedur ist ebenfalls mehrphasig.  

Die hier downloadbaren generischen Gluon-Factory-Images können direkt über das Web-GUI der UBNT-Stockfirmware geflasht werden und bieten danach dann dem Nutzer die Möglichkeit, über die Gluon-Konfigseite ein Sysupgrade-Image einer beliebigen Community auf einen EdgeRouter X aufzuspielen. Die komplett abgespeckten generischen Gluon-Factory-Images sind ansonsten funktionslos.  

</br>  
</br> 

![image](https://forum.freifunk.net/uploads/default/a3e57a464efc0bddb7994ffc51d3d29bad0f8a6b)  

---

</br>

# Los geht's: Gluon auf einen EdgeRouter X flashen
Wenn ein EdgeRouter X auf Gluon umgeflasht werde soll, dann wird folgendes benötigt:
- Ein hier bereitgestelltes generisches Gluon-initramfs-Factory-Image:
    - Für einen EdgeRouter X: [gluon-ramips-mt7621-ubnt-erx-initramfs-factory.tar](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/raw/master/gluon-ramips-mt7621-ubnt-erx-initramfs-factory.tar)
    - Für einen EdgeRouter X-SFP: [gluon-ramips-mt7621-ubnt-erx-sfp-initramfs-factory.tar](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/raw/master/gluon-ramips-mt7621-ubnt-erx-sfp-initramfs-factory.tar) 
- Ein Community-spezifisches Gluon-Sysupgrade-Image für einen EdgeRouter X, EdgeRouter X-SFP. 

## Phase 1 -> Generisches Gluon-Factory über das UBNT Web-GUI flashen
- Ein neuer EdgeRouter X hat die feste IP 192.168.1.1, es läuft kein DHCP auf dem Router.  
- Der EdgeRouter X muß über den eth0-Port (WAN) mit einem PC verbunden werden.
- Der verbundendene PC muss mit einer passenden statischen IP konfiguriert werden (z.B. 192.168.1.20).    
- Der EdgeRouter X ist nun über [https://192.168.1.1/](https://192.168.1.1/) zu erreichen.  
- Nach dem Login (Benutzer: "ubnt", Passwort: "ubnt") dann unten links auf 'System' klicken. 
- Im Fenster runterscrollen und bei "Upgrade System Image" eines der hier bereitgestellten generischen Gluon-initramfs-Factory Images verwenden.
- Den Anweisungen folgen (inkl. Reboot).
- Weiter mit Phase 2

## Phase 2 -> Gluon-Sysupgrade über die Gluon-Konfigseite
- Nach dem Booten des EdgeRouters ist die Gluon-Konfigseite per Web-Browser über [http://192.168.1.1/](http://192.168.1.1/) zu ereichen.
- Der EdgeRouter X muß nun über einen der Ports eth1-4 (LAN) mit dem PC verbunden werden.
- Den PC ggf. wieder so konfigurieren, dass er seine IP per DHCP erhält.
- Evtl. den Browser-Cache, -Verlauf, etc. löschen. Es kann sonst zu Browser-Problemen wegen des vorherigen http"**s**"-Zugriffs auf 192.168.1.1 kommen.
- Nun über die Gluon-Konfigseite ein Sysupgrade mit einem Image einer beliebigen Community durchführen.
- Weiter mit Phase 3

## Phase 3 -> Einrichten der eigenen Community-Firmware
- Nach dem Booten sollte über [http://192.168.1.1/](http://192.168.1.1/) die Gluon-Konfigseite der Community-spezifischen Firmware angezeigt werden.

Done!

---

# Per Konsole zurück zur UBNT-Stockfirmware
Gute Nachrichten:  
Ein EdgeRouter X mit einer bereits aufgespielten Gluon- oder OpenWrt-Firmware läßt sich sehr einfach über die Konsole auf die original UBNT-Stockfrimware zurückflashen.  
  
  
Dieses Projekt basiert auf einem initramfs-Kernel. Ein Gluon/OpenWrt EdgeRouter X kann mit Hilfe der folgenden Anleitung überredet werden, diesen initramfs-Kernel beim Booten zu laden. Danach liegt ein Gluon-System vor, welches vollständig im RAM abläuft (der Kernel, wie auch das Filesystem). Dadurch wird der Flash-Speicher von der laufenden Firmware nicht eingebunden. Somit kann dort (im Flash-Speicher) die UBNT-Stockfirmware ohne Probleme abgelegt werden. Die Prozedur ist mehrphasig.  
  
Wenn ein Gluon- oder OpenWrt-EdgeRouter zurück auf die UBNT-Stockfirmware geflasht werde soll, dann wird folgendes benötigt:
- Ein hier bereitgestelltes "Back to Stock"-initramfs-Binary
   - Für einen EdgeRouter X: [back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/raw/master/back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin)
   - Für einen EdgeRouter X-SFP: [back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin](https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/raw/master/back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin) 
- Eine original UBNT Stockfirmware für den EdgeRouter X, EdgeRouter X-SFP: [https://www.ubnt.com/download/edgemax/edgerouter-x](https://www.ubnt.com/download/edgemax/edgerouter-x)

## Phase 1 -> Flashen des initramfs-Binaries
- Das "Back to Stock"-initramfs-Binary irgendwie auf den umzuflashenden Gluon- bzw. OpenWrt-EdgeRouter in den Ordner `/tmp` transferieren (z.B. mit "scp").
- Per SSH auf den umzuflashenden Gluon- bzw. OpenWrt-EdgeRouter verbinden.
- Auf der Router-Konsole wird dann das "Back to Stock"-initramfs-Binary in die Flash-Kernel-Partitionen "mtdblock3" und "mtdblock4" übertragen:  
    - Bei einem EdgeRouter X bitte folgende Befehlsfolge verwenden:  
    ```
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin of=/dev/mtdblock3
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-initramfs-kernel.bin of=/dev/mtdblock4
    ```
    - Bei einem EdgeRouter X-SFP bitte folgende Befehlsfolge verwenden:  
    ```
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin of=/dev/mtdblock3
    dd if=/tmp/back-to-stock-ramips-mt7621-ubnt-erx-sfp-initramfs-kernel.bin of=/dev/mtdblock4
    ```
- Mit `'reboot'` den EdgeRouter X neu starten.
- Weiter mit Phase 2

## Phase 2 -> Flashen der UBNT-Stockfirmware
- Der EdgeRouter X muß über einen der Ports eth1-4 (LAN) mit einem PC verbunden werden.
- Den PC ggf. so konfigurieren, dass er seine IP per DHCP erhält.
- Die [UBNT-Stockfirmware](https://www.ubnt.com/download/edgemax/edgerouter-x) auf dem PC lokal entpacken und die Dateien `version.tmp, squashfs.tmp, squashfs.tmp.md5, und vmlinux.tmp` irgendwie auf den umzuflashenden EdgeRouter X in den Ordner `/tmp` transferieren (z.B. mit "scp").
- **Bitte wirklich /tmp als Zielpfad verwenden. Ansonsten können die folgenden Befehlsfolgen zu einem Brick des Routers führen!**
- Dann mittels `'ssh root@192.168.1.1'` auf dem EdgeRouters X einloggen (ein Passwort wird nicht abgefragt).
- Auf der Router-Konsole wird nun mit folgenden Befehlen die UBNT-Stockfirmware auf den EdgeRouters X geflasht:  
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
- Nach dem Anmelden (Benutzer: "ubnt", Passwort: "ubnt") den EdgeRouter X nach Belieben konfigurieren.

Done!  

---

# ERX Factory-Image selberbauen
folgt  

---

# Interessante Links
- [FF-Greifswald: Test: EdgeRouter X als Offloader](https://ffhgw.de/test-edgerouter-x-als-offloader)
- [OpenWRT Wiki: Ubiquiti EdgeRouter X (ER-X), EdgeRouter X-SFP (ER-X-SFP) and EdgePoint R6 (EP-R6)](https://openwrt.org/toh/ubiquiti/ubiquiti_edgerouter_x_er-x_ka) 
- [FF-Winterberg: Die Nutzung von Ubiquiti EdgeRouter-X als Freifunk Offloader](https://www.freifunk-winterberg.net/die-nutzung-von-ubiquiti-edgerouter-x-als-freifunk-offloader)
- [ERX, ERX-SFP System Recovery per serieller Schnittstelle und TFTP](https://community.ubnt.com/t5/EdgeMAX/ERX-ERX-SFP-System-Recovery/td-p/2056921) 
- [Sector5D-Blog: OpenWRT on the Ubiquiti EdgeRouter X](http://sector5d.org/openwrt-on-the-ubiquiti-edgerouter-x.html)

<br>

- [UBNT: Quickstart Guide EdgeRouter X](https://dl.ubnt.com/guides/edgemax/EdgeRouter_ER-X_QSG.pdf)
- [UBNT: Downloadseite der original UBNT-Stockfirmware für EdgeRouter X und EdgeRouter X-SFP](https://www.ubnt.com/download/edgemax/edgerouter-x)
