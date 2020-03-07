# Bauanleitung für UBNT-ERX Factory-Images mit Gluon v2020.1 als Basis

```
# Projekt-Release-Name
export RELEASE_NAME="UBNT-ERX-GenericFactoryImage-v2.0__Gluon-v2020.1"


# Holen von Gluon v2020.1
git clone https://github.com/freifunk-gluon/gluon.git erxfactory
cd erxfactory
git checkout -b v2020.1

# Site erstellen
mkdir site
cd site
wget https://github.com/oszilloskop/UBNT_ERX_Gluon_Factory-Image/archive/master.zip
unzip master.zip
cp UBNT_ERX_Gluon_Factory-Image-master/build/site/* .

# Die Gluon-Build-Umgebung benötigt hier ein Git-Repo ...
# ... daher wird hier ein leeres Git-Repo anlegen

git init
# git config --local user.email "gluon@ubnt.erx"
# git add site.conf  site.mk
# git commit -m "dummy"
# git tag -a "_" -m "dummy"
cd ..
make update

# Achtung!
# Ich nutze einen eigenen OpenWrt-Source-Package-Download-Cache-Ordner.
# Daher folgend eine eigene lokalisierte Befehlszeile:
cd openwrt; ln -s ../../dl-cache dl ; cd ..

# Der absolute Pfad zum Site-Ordner kann variieren.
# Daher wird er hier ausfindig gemacht.
export PATH_TO_SITEDIR=$(realpath site)

# Irgendwie muss das ganze dann einmalig durchgebaut werden.
make -j4 GLUON_TARGET=ramips-mt7621 GLUON_DEVICES="ubnt-erx ubnt-erx-sfp"

cd openwrt

# Für den Bau der initrams-Binaries die Dateien und die .config aus meinem Repo verwenden.
cp -R ../site/UBNT_ERX_Gluon_Factory-Image-master/build/openwrt/files .
cp ../site/UBNT_ERX_Gluon_Factory-Image-master/build/openwrt/.config .

# .config übernehmen
make defconfig

# Bauen
make -j4 CONFIG_GLUON_RELEASE=$RELEASE_NAME CONFIG_GLUON_SITEDIR=$PATH_TO_SITEDIR


# Wenn der Build am Ende failed, dann nochmal folgendes nachsetzten:
make -j1 CONFIG_GLUON_RELEASE=$RELEASE_NAME CONFIG_GLUON_SITEDIR=$PATH_TO_SITEDIR

ls -l bin/targets/ramips/mt7621/

# Die Images finden sich dann hier: erxfactory/openwrt/bin/targets/ramips/mt7621/

```

