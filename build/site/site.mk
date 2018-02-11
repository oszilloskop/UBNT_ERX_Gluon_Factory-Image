GLUON_SITE_PACKAGES := \
        gluon-setup-mode \
        gluon-config-mode-core \
        gluon-config-mode-autoupdater \
        gluon-web-admin \
        gluon-status-page \
        haveged \
        -opkg \

#####################################################################################################################

# Gluon Base Release
DEFAULT_GLUON_RELEASE := GluonFactoryImage-v1.0

# Allow overriding the release number from the command line
GLUON_RELEASE ?= $(DEFAULT_GLUON_RELEASE)

