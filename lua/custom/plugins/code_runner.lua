-- Code Runner configuration
-- https://github.com/CRAG666/code_runner.nvim

return {
  "CRAG666/code_runner.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- Lazy load on commands
  cmd = {
    "RunCode", "RunFile", "RunProject", 
    "RunClose", "CRFiletype", "CRProjects"
  },
  config = function()
    require("code_runner").setup({
      -- Choose default mode (valid term, tab, float, toggle, buf)
      mode = "float",
      
      -- Focus on runner window
      focus = true,
      
      -- Start runner when run key is pressed
      startinsert = true,
      
      -- Close terminal window after process exit
      term = {
        position = "bot",
        size = 12,
      },
      
      float = {
        -- Window border and appearance
        border = "rounded",
        height = 0.7,
        width = 0.7,
        x = 0.5,
        y = 0.5,
        border_hl = "FloatBorder",
        float_hl = "Normal",
        close_on_exit = true,
      },
      
      -- Language-specific commands (optimized order)
      filetype = {
        python = "python3 -u $fileName",
        javascript = "node $fileName",
        typescript = "ts-node $fileName",
        rust = "cargo run",
        go = "go run $fileName",
        cpp = "g++ $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
        c = "gcc $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
        java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
        sh = "bash $fileName",
        lua = "lua $fileName",
        php = "php $fileName",
        ruby = "ruby $fileName",
        perl = "perl $fileName",
        r = "Rscript $fileName",
        dart = "dart $fileName",
        julia = "julia $fileName",
        kotlin = "kotlinc $fileName -include-runtime -d $fileNameWithoutExt.jar && java -jar $fileNameWithoutExt.jar",
        swift = "swift $fileName",
        haskell = "runhaskell $fileName",
        lisp = "clisp $fileName",
        elixir = "elixir $fileName",
        matlab = "matlab -nodisplay -nosplash -nodesktop -r \"run('$fileName');exit;\"",
      },
      
      -- Project-specific configuration (optimized)
      project = {
        name = ".projectile",
        
        -- Patterns to identify project type (ordered by frequency)
        patterns = {
          ["package.json"] = { command = "npm start", name = "npm project" },
          ["Cargo.toml"] = { command = "cargo run", name = "cargo project" },
          ["go.mod"] = { command = "go run .", name = "go project" },
          ["Makefile"] = { command = "make", name = "make project" },
          ["pom.xml"] = { command = "mvn compile exec:java", name = "maven project" },
        },
      },
    })
  end,
  -- Define keymaps directly in the keys table for better compatibility
  keys = {
    { "<leader>r", ":RunCode<CR>", desc = "Run code" },
    { "<leader>rf", ":RunFile<CR>", desc = "Run current file" },
    { "<leader>rp", ":RunProject<CR>", desc = "Run project" },
    { "<leader>rc", ":RunClose<CR>", desc = "Close runner" },
    { "<leader>crf", ":CRFiletype<CR>", desc = "Run custom command for filetype" },
    { "<leader>crp", ":CRProjects<CR>", desc = "Run custom command for project" },
  }
}
