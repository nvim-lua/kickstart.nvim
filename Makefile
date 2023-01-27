format:
	alejandra --quiet .
	lua-format --in-place init.lua
	find fnl -name "*.fnl" -exec fnlfmt --fix {} \;

to-lua:
	bash scripts/switch-to-lua.sh

to-fnl:
	bash scripts/switch-to-fnl.sh

.PHONY: format to-lua to-fnl
