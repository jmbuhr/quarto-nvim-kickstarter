
vim.filetype.add({
  extension = {
    cp2k = 'cp2k',
    inp = 'cp2k',
  },
  pattern = {
    ['.*cp2k.*%.inp'] = 'cp2k',
  },
})


