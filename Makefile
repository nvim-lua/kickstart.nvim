format:
	alejandra --quiet .
	lua-format --in-place init.lua

.PHONY: format
