local command = {}
local lsprename = require('lspsaga.rename')
local diagnostic = require('lspsaga.diagnostic')
local codeaction = require('lspsaga.codeaction')
local finder = require('lspsaga.finder')

local subcommands = {
  lsp_finder = function()
    finder:lsp_finder()
  end,
  preview_definition = function()
    require('lspsaga.definition'):preview_definition()
  end,
  rename = function()
    lsprename:lsp_rename()
  end,
  hover_doc = function()
    require('lspsaga.hover'):render_hover_doc()
  end,
  show_cursor_diagnostics = diagnostic.show_cursor_diagnostics,
  show_line_diagnostics = diagnostic.show_line_diagnostics,
  diagnostic_jump_next = diagnostic.goto_next,
  diagnostic_jump_prev = diagnostic.goto_prev,
  code_action = function()
    codeaction:code_action()
  end,
  range_code_action = function()
    codeaction:range_code_action()
  end,
  open_floaterm = function(cmd)
    require('lspsaga.floaterm'):open_float_terminal(cmd)
  end,
  close_floaterm = function()
    require('lspsaga.floaterm'):close_float_terminal()
  end,
}

function command.command_list()
  return vim.tbl_keys(subcommands)
end

function command.load_command(cmd, ...)
  local args = { ... }
  if next(args) ~= nil then
    subcommands[cmd](args[1])
  else
    subcommands[cmd]()
  end
end

return command
