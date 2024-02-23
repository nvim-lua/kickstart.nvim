return {
  'huggingface/llm.nvim',
  enabled = false,
  opts = {
    backend = 'ollama',
    model = 'stable-code',
    url = 'http://localhost:11434/api/generate',

    tokens_to_clear = { '<EOT>' },
    fim = {
      enabled = true,
      prefix = '<PRE> ',
      middle = ' <MID>',
      suffix = ' <SUF>',
    },
    context_window = 4096,

    -- cf https://github.com/ollama/ollama/blob/main/docs/api.md#parameters
    request_body = {
      -- Modelfile options for the model you use
      options = {
        temperature = 0.2,
        top_p = 0.95,
      },
    },
  },
}
