# Local preview of the hosted pages. Override the port with `make serve PORT=9000`.
PORT ?= 8000

# Upload target. Docs, cms_stubs.html and the Makefile stay local.
DEPLOY_HOST ?= root@172.16.11.32
DEPLOY_DIR ?= /var/www/html/website
PAGES := $(filter-out cms_stubs.html,$(wildcard *.html))

.PHONY: serve start deploy

serve start:
	@echo "Serving at http://localhost:$(PORT)/"
	python3 -m http.server $(PORT) --bind 127.0.0.1

deploy:
	scp -r $(PAGES) css images pdf $(DEPLOY_HOST):$(DEPLOY_DIR)
