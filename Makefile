# Express Foundation Seed Makefile
# ================================
#
# > (c) 2013 Chao Huang
# > <chao@realguess.net>

APP_NAME := express-foundation-seed
FOUNDATION_VERSION := 4.0.9
FILE_TMP := /tmp/foundation.zip
SRC_FILES_URL := https://raw.github.com/realguess/reference/master/files
SRC_GITIGNORE := ${SRC_FILES_URL}/git/gitignore
SRC_JSHINTRC  := ${SRC_FILES_URL}/jshint/node.jshint

# Generate Express Foundation Seed
# --------------------------------
seed:
	@# Create Express app with Hogan.js rendering engine.
	express -H ${APP_NAME}
	@
	@# Download Foundation.
	wget -q -O ${FILE_TMP} http://foundation.zurb.com/files/foundation-${FOUNDATION_VERSION}.zip
	@
	@# Remove everything the public directory.
	rm -r ${APP_NAME}/public/*
	@
	@# Extract Foundation to the public directory.
	unzip -d ${APP_NAME}/public ${TMP_FILE}
	@
	@# Move and replace index view page.
	mv ${APP_NAME}/public/index.html ${APP_NAME}/views/index.hjs

# Generate Express Foundation Project
# -----------------------------------
project: seed
	@# Replace tab with 2 spaces.
	sed -i 's/\t/  /g' ${APP_NAME}/views/index.hjs
	@
	@# Create gitignore file.
	wget -q -O ${APP_NAME}/.gitignore ${SRC_GITIGNORE}
	@
	@# Create jshintrc file.
	wget -q -O ${APP_NAME}/.jshintrc ${SRC_JSHINTRC}

# Generate documentation
# ----------------------
docs:
	cp README.md /tmp/README.litcoffee
	docco -o docs/ /tmp/README.litcoffee
	rm /tmp/README.litcoffee

.PHONY: seed docs
