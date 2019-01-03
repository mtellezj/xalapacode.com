.PHONY: all site css

STATIC_DIR = themes/xalapacode/static/

all: site css

site:
	hugo

css:
	sass $(STATIC_DIR)scss/main.scss:$(STATIC_DIR)css/main.css --style=compressed
