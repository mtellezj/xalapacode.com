.PHONY: all site css

STATIC_DIR = themes/xalapacode/static/

all: css site

site:
	hugo

css:
	sass $(STATIC_DIR)scss/main.scss $(STATIC_DIR)css/main.css --style=compressed
