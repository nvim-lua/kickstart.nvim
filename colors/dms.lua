local present, base46 = pcall(require, "base46")
if not present or not base46._DMS_SUPPORT then
	vim.notify(
		"base46 plugin not found or incorrect, make sure to install AvengeMedia/base46",
		vim.log.levels.ERROR,
		{ title = "dms integration" }
	)
	return
end

local config_home = vim.env.XDG_CONFIG_HOME
if config_home == nil or #config_home == 0 then
	config_home = vim.fs.joinpath(vim.env.HOME, ".config")
end
local settings_file_path = vim.fs.joinpath(config_home, "DankMaterialShell", "settings.json")
local settings_file = io.open(settings_file_path, "r")
if settings_file == nil then
	vim.notify(
		"cannnot read dms settings file at '" .. settings_file_path .. "'",
		vim.log.levels.ERROR,
		{ title = "dms integration" }
	)
	return
end
local settings = vim.json.decode(settings_file:read("*a"))
settings_file:close()

local function deepGet(t, k)
	for _, s in ipairs(k) do
		if type(t) ~= "table" then
			return
		end
		t = t[s]
	end
	return t
end

local current_file_path = debug.getinfo(1, "S").source:sub(2)
local theme_base = deepGet(settings, { "matugenTemplateNeovimSettings", vim.o.background, "baseTheme" })
	or ("github_" .. vim.o.background)
local harmony = deepGet(settings, { "matugenTemplateNeovimSettings", vim.o.background, "harmony" }) or 0.5
local theme_name = "dms"

if not _G._matugen_theme_watcher then
	local uv = vim.uv or vim.loop
	_G._matugen_theme_watcher = { uv.new_fs_event(), uv.new_fs_event(), reload_timer = uv.new_timer() }

	local debounce_time = 100 -- ms
	local function handler()
		_G._matugen_theme_watcher.reload_timer:stop()
		_G._matugen_theme_watcher.reload_timer:start(
			debounce_time,
			0,
			vim.schedule_wrap(function()
				base46.theme_tables[theme_name] = nil
				if vim.g.colors_name == theme_name then
					vim.cmd.colorscheme(theme_name)
					vim.notify("Theme reload", vim.log.levels.INFO, { title = "dms integration" })
				end
				-- NOTE: contrary to what the documentation says, uv fs events usually do not manage to react to more than one edit.
				-- I understand that this is not intended: some edit processes in a typical system (e.g. the one neovim uses with
				-- multiple renames and changes) make things hard to follow for libuv. Therefore, a restart is the best option.
				_G._matugen_theme_watcher[1]:stop()
				_G._matugen_theme_watcher[2]:stop()
				_G._matugen_theme_watcher[1]:start(current_file_path, {}, handler)
				_G._matugen_theme_watcher[2]:start(settings_file_path, {}, handler)
			end)
		)
	end
	_G._matugen_theme_watcher[1]:start(current_file_path, {}, handler)
	_G._matugen_theme_watcher[2]:start(settings_file_path, {}, handler)
end

if not base46.theme_tables[theme_name] or base46.theme_tables[theme_name].type ~= vim.o.background then
	local builtin = vim.deepcopy(assert(base46.get_builtin_theme(theme_base)))
	local harmonized = base46.theme_harmonize(builtin, "#89b4fa", harmony)
	harmonized = base46.theme_set_bg(harmonized, "#1e1e2e")

	base46.theme_tables[theme_name] = harmonized
end

base46.load(theme_name)
vim.g.colors_name = theme_name
