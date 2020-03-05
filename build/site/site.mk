GLUON_SITE_PACKAGES := \
        gluon-config-mode-autoupdater \
        haveged \
        -opkg \


##################################################################################################################$

# Gluon Base Release
DEFAULT_GLUON_RELEASE := GluonFactoryImage-v2.0

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

# Languages to include.
GLUON_LANGS ?= de en

# Do not build images for deprecated devices
GLUON_DEPRECATED ?= 0
