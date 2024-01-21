return {
	"David-Kunz/gen.nvim",
	config = function()
		require('gen').prompts['Elaborate_Text'] = {
			prompt = "Elaborate the following text:\n$text",
			replace = true
		}
		require('gen').prompts['Golang'] = {
			prompt = "You are a senior Golang engineer, acting as an assitant. You offer help with backend tecnologies: \
			mongodb, gorilla/mux, algorithms, data structures, azure cloud, terraform. You answer with code examples when \
			possible. $input:\n$text",
			replace = true
		}

		require('gen').setup({
			model = "codellama", -- The default model to use.
			display_mode = 'split',
		})

		vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>')
		vim.keymap.set('v', '<leader>]', ':Gen Enhance_Grammar_Spelling<CR>')
	end
	-- opts = {
	-- 	model = "mistral",    -- The default model to use.
	-- 	display_mode = "float", -- The display mode. Can be "float" or "split".
	-- 	show_prompt = false,  -- Shows the Prompt submitted to Ollama.
	-- 	show_model = false,   -- Displays which model you are using at the beginning of your chat session.
	-- 	no_auto_close = false, -- Never closes the window automatically.
	-- 	init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
	-- 	-- Function to initialize Ollama
	-- 	command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
	-- 	-- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
	-- 	-- This can also be a lua function returning a command string, with options as the input parameter.
	-- 	-- The executed command must return a JSON object with { response, context }
	-- 	-- (context property is optional).
	-- 	-- list_models = '<omitted lua function>',     -- Retrieves a list of model names
	-- 	debug = false -- Prints errors and the command which is run.
	-- }
}
