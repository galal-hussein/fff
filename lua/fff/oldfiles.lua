local M = {}

function M.get_old_files(oldfiles_list)
  oldfiles_list = oldfiles_list or vim.v.oldfiles
  local items = {}
  for _, oldfile in ipairs(oldfiles_list) do
    table.insert(items, {
      path = oldfile,
      relative_path = vim.fn.fnamemodify(oldfile, ':~:.'),
      name = vim.fn.fnamemodify(oldfile, ':t'),
      extension = vim.fn.fnamemodify(oldfile, ':e'),
    })
  end
  M.oldfiles_count = #vim.v.oldfiles
  M.oldfiles_total_matched = #items
  return items
end

function M.search_old_files(query)
  local results = vim.fn.matchfuzzy(vim.v.oldfiles, query)
  return M.get_old_files(results)
end

function M.get_oldfiles_metadata() return { total_files = M.oldfiles_count, total_matched = M.oldfiles_total_matched } end
return M
