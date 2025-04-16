return {
  'jackMort/ChatGPT.nvim',
  event = 'VeryLazy',
  config = function()
    vim.api.nvim_set_hl(0, 'ChatGPTNormalFloat', { bg = 'NONE', fg = 'NONE' })
    vim.api.nvim_set_hl(0, 'ChatGPTFloatBorder', { bg = 'NONE', fg = 'NONE' })
    require('chatgpt').setup {
      api_key_cmd = nil,
      yank_register = '+',
      edit_with_instructions = {
        diff = false,
        keymaps = {
          close = '<C-c>',
          accept = '<C-y>',
          toggle_diff = '<C-d>',
          toggle_settings = '<C-o>',
          cycle_windows = '<Tab>',
          use_output_as_input = '<C-i>',
        },
      },
      chat = {
        loading_text = 'Loading, please wait ...',
        question_sign = '', -- 🙂
        -- answer_sign = 'ﮧ', -- 🤖
        answer_sign = '🤖',
        max_line_length = 120,
        sessions_window = {
          border = {
            style = 'rounded',
            text = {
              top = ' Sessions ',
            },
          },
          win_options = {
            winhighlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
          },
        },
      },
      keymaps = {
        close = { '<C-c>' },
        yank_last = '<C-y>',
        yank_last_code = '<C-k>',
        scroll_up = '<C-u>',
        scroll_down = '<C-d>',
        new_session = '<C-n>',
        cycle_windows = '<Tab>',
        cycle_modes = '<C-f>',
        next_message = '<C-j>',
        prev_message = '<C-k>',
        select_session = '<Space>',
        rename_session = 'r',
        delete_session = 'd',
        draft_message = '<C-d>',
        edit_message = 'e',
        delete_message = 'd',
        toggle_settings = '<C-o>',
        toggle_message_role = '<C-r>',
        toggle_system_role_open = '<C-s>',
        stop_generating = '<C-x>',
      },
      popup_layout = {
        default = 'center',
        center = {
          width = '60%',
          height = '80%',
        },
        right = {
          width = '30%',
          width_settings_open = '50%',
        },
      },
      popup_window = {
        border = {
          highlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
          style = 'rounded',
          text = {
            top = ' ChatGPT ',
          },
        },
        win_options = {
          wrap = true,
          linebreak = true,
          foldcolumn = '1',
          winhighlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
        },
        buf_options = {
          filetype = 'markdown',
        },
      },
      system_window = {
        border = {
          highlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
          style = 'rounded',
          text = {
            top = ' SYSTEM ',
          },
        },
        win_options = {
          wrap = true,
          linebreak = true,
          foldcolumn = '2',
          winhighlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
        },
      },
      popup_input = {
        prompt = '  ',
        border = {
          highlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
          style = 'rounded',
          text = {
            top_align = 'center',
            top = ' Prompt ',
          },
        },
        win_options = {
          winhighlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
        },
        submit = '<C-Enter>',
        submit_n = '<Enter>',
        max_visible_lines = 20,
      },
      settings_window = {
        border = {
          style = 'rounded',
          text = {
            top = ' Settings ',
          },
        },
        win_options = {
          winhighlight = 'Normal:ChatGPTNormalFloat,FloatBorder:ChatGPTFloatBorder',
        },
      },
      -- this config assumes you have OPENAI_API_KEY environment variable set
      openai_params = {
        model = 'gpt-4o-mini',
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      },
      openai_edit_params = {
        model = 'gpt-3.5-turbo',
        frequency_penalty = 0,
        presence_penalty = 0,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
    }
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
