GLUON_SITE_PACKAGES := \
        gluon-web-admin \
        gluon-config-mode-autoupdater \
        haveged \
        -opkg \


##################################################################################################################$

# Allow overriding the release number from the command line
GLUON_RELEASE ?= Dummy

# Languages to include.
GLUON_LANGS ?= de en

# Do not build images for deprecated devices
GLUON_DEPRECATED ?= 0
