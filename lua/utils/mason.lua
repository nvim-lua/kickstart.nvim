local M = {}

-- any cases where name of package is different from the binary name
local name_to_bin = {
	["csharp-language-server"] = "csharp-ls",
	["python-lsp-server"] = "pylsp",
	["docker-compose-language-service"] = "docker-compose-langserver",
}

M.install = function(ensure_installed)
	-- Allow for passing in a single string
	if type(ensure_installed) == "string" then
		ensure_installed = { ensure_installed }
	end

	-- Function to check if the executable exists in the PATH
	local function executable_exists(name)
		if name_to_bin[name] then
			return vim.fn.executable(name) == 1 or vim.fn.executable(name_to_bin[name]) == 1
		end
		return vim.fn.executable(name) == 1
	end

	local registry = require("mason-registry")
	registry.refresh(function()
		for _, pkg_name in ipairs(ensure_installed) do
			local pkg = registry.get_package(pkg_name)
			if not executable_exists(pkg_name) and not pkg:is_installed() then
				pkg:install()
			end
		end
	end)
end

return M