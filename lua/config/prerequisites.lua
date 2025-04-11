local dependencies = {
  'gcc',
  'rg',
  'composer',
  'node',
  'npm',
  'lazygit',
  'nvr',
}

for index, dependency in pairs(dependencies) do
  if vim.fn.executable(dependency) == 0 then
    print('Missing executable: ' .. dependency .. ' (' .. index .. ')')
  end
end
