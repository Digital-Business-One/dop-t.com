HUGO ?= hugo

.PHONY: page serve build check test

## make page SLUG=pricing — scaffold the EN+PT-BR pair sharing one translationKey
page:
ifndef SLUG
	$(error Usage: make page SLUG=pricing)
endif
	$(HUGO) new content/en/$(SLUG).md
	$(HUGO) new content/pt-br/$(SLUG).md
	@echo "Created the EN + PT-BR pair for '$(SLUG)'. Write both, then push."

## Live preview, drafts included
serve:
	$(HUGO) server -D

## Production build — what CI runs
build:
	$(HUGO) --minify --gc

## The local gate: it builds AND refuses a page that exists in one language only
check: build
	python3 scripts/check_translations.py content

## The translation checker's own tests
test:
	./tests/check_translations_test.sh
