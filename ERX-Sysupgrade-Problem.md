# Update UBNT EdgeRouter X (X-SFP) von Gluon v2019.x (oder älter) auf Gluon v2020.1 (oder neuer)

  
Mit Gluon v2020.1 gab es einen Wechsel des NAND-Flash-Handlings bei Ubiquiti EdgeRouter X bzw. X-SFP.  
Falls defekte Flash-Speicherzellen vorhanden sind, welche bisher keine Probleme bereiteten, so kann ein normales Sysupgrade von Gluon 2019.x (oder älter) auf Gluon v2020.1 (oder neuer) zu einem Soft-Brick führen!

Siehe dazu das Gluon-Issue [#1937](https://github.com/freifunk-gluon/gluon/issues/1937).  

### Es kann sehr einfach überprüft werden, ob ein anstehendes Sysupgrade von Gluon v2019.x (oder älter) auf Gluon v2020.1 (oder neuer) zu einem Soft-Brick führt.

Bitte per SSH auf den entsprechenden EdgeRouter anmelden.

Folgende Befehlsfolge gibt Aufschluss darauf, ob bereits defekte FLASH-Zellen vorhanden sind:

```
dmesg | grep 'Bad eraseblock'
```
Kommt es zu keiner Ausgabe, dann kann der EdgeRouter sorgenfrei per `autoupgrade` oder per `sysupgrade` auf jede beliebige Gluon-Version aktualisiert werden.

Kommt es jedoch zu einer Ausgabe wie z.B.

```
[    1.529273] Bad eraseblock 1157 at 0x0000090a0000
``` 
dann bitte die folgend beschriebenen Schritte durchführen.

---

# Von Gluon v2019.x (oder älter) auf Gluon v2020.1 (oder neuer) per SSH-Konsole
### Vorab:
Mit der folgend beschriebenen Methode wird der EdgeRouter **komplett** zurückgesetzt (analog zum jungfräulichen Factory-Zustand) und in den Konfigmodus versetzt. Es ist also **zwingend** der physische Zugriff auf den Router notwendig!

Was bei der folgend beschrieben Methode jedoch entfällt, ist die Anwendung von TFTP in Kombination mit einem Hardware-Zugang per serieller TTL-Schnittstelle.

Anwendung der folgend beschriebene Methode auf eigene Gefahr :)


## Methodenbeschreibung  
Die Methode basiert auf einem generischem Gluon v2020.1 mit initramfs-Kernel. 

Jeder Gluon EdgeRouter X (X-SFP) kann mit Hilfe der folgenden Anleitung überredet werden, diesen initramfs-Kernel beim Booten zu laden. Nach dem Booten liegt dann ein Gluon-System vor, welches vollständig im RAM abläuft (der Kernel, wie auch das Filesystem). Dadurch wird von der Firmware **kein** Filesystem aus dem Flash-Speicher eingebunden. Evtl. vorhandene defekte FLASH-Zellen haben daher keinen negativen Einfluss auf den Bootvorgang des Systems.

Die generische initramfs-Firmware stellt einen jungfräulichen Router mit Gluon v2020.1 im Konfigmodus bereit. (Das generische Gluon hat keinerlei weitere Eigenschaften/Funktionen.) 

Die Prozedur ist mehrphasig.

## Vorbereitungen
Wenn ein Gluon EdgeRouter von Gluon v2019.x (oder älter) auf Gluon v2020.1 (oder neuer) aktualisiert werde soll, dann wird folgendes benötigt:
- Ein hier bereitgestelltes initramfs-Binary
   - Für einen EdgeRouter X: [Gluon2020.1-back-to-stock-ubnt-erx-initramfs-kernel.bin](Gluon2020.1-back-to-stock-ubnt-erx-initramfs-kernel.bin)
   - Für einen EdgeRouter X-SFP: [Gluon2020.1-back-to-stock-ubnt-erx-sfp-initramfs-kernel.bin](Gluon2020.1-back-to-stock-ubnt-erx-sfp-initramfs-kernel.bin) 

## Phase 1 -> Flashen des generischen initramfs-Binaries
- Das initramfs-Binary irgendwie auf den umzuflashenden Gluon-EdgeRouter in den Ordner `/tmp` transferieren (z.B. mit "scp").
- Per SSH auf den umzuflashenden Gluon-EdgeRouter verbinden.
- Auf der Router-Konsole wird dann das initramfs-Binary in die Flash-Kernel-Partitionen "mtdblock3" und "mtdblock4" übertragen:  
    - Bei einem EdgeRouter X bitte folgende Befehlsfolge verwenden:  
    ```
    dd if=/tmp/Gluon2020.1-back-to-stock-ubnt-erx-initramfs-kernel.bin of=/dev/mtdblock3
    dd if=/tmp/Gluon2020.1-back-to-stock-ubnt-erx-initramfs-kernel.bin of=/dev/mtdblock4
    ```
    - Bei einem EdgeRouter X-SFP bitte folgende Befehlsfolge verwenden:  
    ```
    dd if=/tmp/Gluon2020.1-back-to-stock-ubnt-erx-initramfs-kernel.bin of=/dev/mtdblock3
    dd if=/tmp/Gluon2020.1-back-to-stock-ubnt-erx-sfp-initramfs-kernel.bin of=/dev/mtdblock4
    ```
- Mit `'reboot'` den EdgeRouter X neu starten.
- Weiter mit Phase 2

## Phase 2 -> Gluon-Sysupgrade über die Gluon-Konfigseite
- Der EdgeRouter muß nun über einen der Ports eth1-4 (LAN) mit dem PC verbunden werden.
- Nach dem Booten des EdgeRouters ist die Gluon-Konfigseite per Web-Browser über [http://192.168.1.1/](http://192.168.1.1/) zu ereichen.
- Nun über die Gluon-Konfigseite ein Sysupgrade mit einem Gluon-Image einer beliebigen Community durchführen (Basis muß hier zwingend Gluon v2020.1 (oder neuer) sein).
- Weiter mit Phase 3

## Phase 3 -> Einrichten der eigenen Community-Firmware
- Nach dem Booten sollte über [http://192.168.1.1/](http://192.168.1.1/) die Gluon-Konfigseite der Community-spezifischen Firmware angezeigt werden.
- Konfiguration des Knotens nach eigenem Ermessen durchführen.

Done!

---
