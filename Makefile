# Local preview of the hosted pages. Override the port with `make serve PORT=9000`.
PORT ?= 8000

.PHONY: serve

start:
	@echo "Serving at http://localhost:$(PORT)/"
	python3 -m http.server $(PORT) --bind 127.0.0.1
