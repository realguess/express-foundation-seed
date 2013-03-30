# Express Foundation Seed Makefile
# ================================
#
# > (c) 2013 Chao Huang
# > <chao@realguess.net>

APP_NAME := express-foundation-seed
TMP_FILE := /tmp/foundation.zip
FOUNDATION_VERSION := 4.0.9

# Generate Express Foundation Seed
# --------------------------------
seed:
	@# Create Express app with Hogan.js rendering engine.
	express -H ${APP_NAME}
	@
	@# Download Foundation.
	wget -q -O ${TMP_FILE} http://foundation.zurb.com/files/foundation-${FOUNDATION_VERSION}.zip
	@
	@# Remove everything the public directory.
	rm -r ${APP_NAME}/public/*
	@
	@# Extract Foundation to the public directory.
	unzip -d ${APP_NAME}/public ${TMP_FILE}
	@
	@# Move and replace index view page.
	mv ${APP_NAME}/public/index.html ${APP_NAME}/views/index.hjs

# Generate documentation
# ----------------------
docs:
	cp README.md /tmp/README.litcoffee
	docco -o docs/ /tmp/README.litcoffee
	rm /tmp/README.litcoffee

.PHONY: seed docs
