return {
  {
    'evanpurkhiser/image-paste.nvim',
    config = function()
      require('image-paste').setup {
        imgur_client_id = os.getenv('IMGUR_CLIENT_ID'),
        paste_script = [[xclip -selection clipboard -t image/png -o]],
      }
    end,
    keys = {
      {
        '<leader>p',
        function()
          require('image-paste').paste_image()
        end,
        mode = 'n',
        desc = 'Paste image from clipboard',
      },
    },
  }
}
