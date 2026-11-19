NVIM ?= nvim
STYLUA ?= stylua

.PHONY: test format-check
test:
	$(NVIM) --headless -u NONE -i NONE -n -c "lua dofile('tests/theme_spec.lua')"

format-check:
	$(STYLUA) --check colors lua tests
