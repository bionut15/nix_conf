{lib, ...}: {
  programs.nvf = {
    enable = false;
    settings = {
      vim = {
        keymaps = [
          {
            key = "<leader>w";
            mode = ["n"];
            action = ":w<CR>";
            silent = true;
            desc = "Save file";
          }
          {
            key = "<leader>e";
            mode = ["n"];
            action = ":Neotree toggle<CR>";
            silent = true;
            desc = "Open NeoTree";
          }
          {
            key = "<C-h>";
            mode = ["n"];
            action = "<C-\\><C-N><C-W>h";
            silent = true;
            desc = "Move to left split";
          }
          {
            key = "<C-j>";
            mode = ["n"];
            action = "<C-W>j";
            silent = true;
            desc = "Move to bottom split";
          }
          {
            key = "<C-k>";
            mode = ["n"];
            action = "<C-W>k";
            silent = true;
            desc = "Move to top split";
          }
          {
            key = "<C-l>";
            mode = ["n"];
            action = "<C-W>l";
            silent = true;
            desc = "Move to right split";
          }
        ];

        statusline = {
          lualine = {
            enable = true;
            theme = "everforest";
            activeSection.a = [
            ];
            activeSection.b = [
            ];
            activeSection.c = [
              ''
                {
                  "mode",
                  icons_enabled = true,
                  padding = 1,
                  fmt =  function(str) return str:sub(1,3) end, separator = {
                    left = ' ',
                    right =  '|'
                  },
                }
              ''
              ''
                {
                  "filename",
                  symbols = {modified = ' ', readonly = ' '},
                  separator = {right = '[', left = ']'}
                }
              ''
              ''
                {
                  "diff",
                  colored = false,
                  diff_color = {
                    -- Same color values as the general color option can be used here.
                    added    = 'DiffAdd',    -- Changes the diff's added color
                    modified = 'DiffChange', -- Changes the diff's modified color
                    removed  = 'DiffDelete', -- Changes the diff's removed color you
                  },
                  symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the diff symbols
                  separator = {right = ' '}
                }
              ''
            ];
            activeSection.x = [
              ''
                {
                  -- Lsp server name
                  function()
                    local buf_ft = vim.bo.filetype
                    local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true }

                    if excluded_buf_ft[buf_ft] then
                      return ""
                      end

                    local bufnr = vim.api.nvim_get_current_buf()
                    local clients = vim.lsp.get_clients({ bufnr = bufnr })

                    if vim.tbl_isempty(clients) then
                      return "No Active LSP"
                    end

                    local active_clients = {}
                    for _, client in ipairs(clients) do
                      table.insert(active_clients, client.name)
                    end

                    return table.concat(active_clients, ", ")
                  end,
                  icon = ' ',
                  separator = {left = ' '},
                }
              ''
              ''
                {
                  "diagnostics",
                  sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
                  symbols = {error = '󰅙  ', warn = '  ', info = '  ', hint = '󰌵 '},
                  colored = true,
                  update_in_insert = false,
                  always_visible = false,
                  diagnostics_color = {
                    color_error = { fg = 'red' },
                    color_warn = { fg = 'yellow' },
                    color_info = { fg = 'cyan' },
                  },
                }
              ''
              ''
                {
                  'searchcount',
                  maxcount = 999,
                  timeout = 120,
                  separator = {left = ' '}
                }
              ''
              ''
                {
                  "branch",
                  icon = ' ',
                  separator = {left = ' '}
                }
              ''
              ''
                {"location"}
              ''
            ];
            activeSection.y = [
            ];
            activeSection.z = [
            ];
          };
        };

        snippets.luasnip.enable = true;
        lsp = {
          enable = true;

          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
        };
        theme = {
          enable = true;
          name = "everforest";
          style = "medium";
          transparent = true;
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          indent-blankline.enable = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
            crates.codeActions = true;
            format.enable = true;
            lsp.enable = true;
          };
          nim.enable = false;
        };
        autopairs.nvim-autopairs.enable = true;

        autocomplete = {
          nvim-cmp.enable = !true;
          blink-cmp.enable = true;
        };

        filetree = {
          neo-tree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        spellcheck = {
          enable = true;
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };
        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          icon-picker.enable = true;
          surround.enable = true;
          smart-splits.enable = true;

          motion = {
            hop.enable = true;

            leap.enable = true;
            precognition.enable = false;
          };
          images = {
            image-nvim.enable = false;
            img-clip.enable = true;
          };
        };
        autocmds = [
          {
            event = ["BufEnter"];
            pattern = ["*"];
            desc = "Enable cursorline, cursorcolumn, laststatus, scrolloff";
            command = "set cursorline | set cursorcolumn | set scrolloff=8";
          }

          {
            event = ["FileType"];
            pattern = ["*"];
            desc = "Set tabstop and shiftwidth";
            command = "set tabstop=8 | set shiftwidth=8 | set expandtab";
          }

          {
            event = ["BufEnter"];
            pattern = ["*"];
            desc = "Enable relative and absolute line numbers";
            command = "set relativenumber | set number";
          }

          {
            event = ["VimEnter"];
            pattern = ["*"];
            desc = "Enable system clipboard and define listchars";
            command = "set clipboard+=unnamedplus | set list | set listchars=eol:↵,space:⋅,trail:•,extends:»,precedes:«";
          }

          {
            event = ["CmdlineEnter"];
            pattern = ["/"];
            desc = "Enable showmatch and disable hlsearch";
            command = "set showmatch | set nohlsearch";
          }
        ];
      };
    };
  };
}
