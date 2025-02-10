return {
  "metakirby5/codi.vim",
  cmd = "Codi",
  config = function()
    vim.g.codi_interpreters = {
      python = {
        bin = {'python3', '-i', '-c', 'import readline; readline.set_auto_history(False)'},
        prompt = '^>>> ',
        quitcmd = 'exit()',
      },
    }
    vim.g.codi_rightalign = false
  end,
}

