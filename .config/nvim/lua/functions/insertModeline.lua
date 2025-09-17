local opt = vim.opt
local api = vim.api

-- Generate modeline
function generateModeline()
  local commentString = opt.commentstring:get() -- Get commentstring for current filetype
  local spaceIfNeeded = ''
  local fileencoding

  -- Use UTF-8 if no fileencoding is set
  if opt.fileencoding:get() == '' then
    fileencoding = 'utf-8'
  else
    fileencoding = opt.fileencoding:get()
  end

  -- Insert space at the end of the modeline if commentstring is a blockcomment
  if string.match(commentString, '%%s(.*)') ~= '' then
    spaceIfNeeded = ' '
  end

  local modelineElements = -- Settings to save inside the modeline
    {
      ' vim',
      ':fenc=' .. fileencoding,
      ':ts=' .. opt.tabstop:get(),
      ':sw=' .. opt.shiftwidth:get(),
      ':sts=' .. opt.softtabstop:get(),
      ':sr',
      ':et',
      ':si',
      ':tw=' .. opt.textwidth:get(),
      ':fdm=' .. opt.foldmethod:get(),
      ':fmr=' .. opt.foldmarker:get()[1] .. ',' .. opt.foldmarker:get()[2],
      spaceIfNeeded,
    }

  local modelineConcat = table.concat(modelineElements) -- Concatenate the table values
  local modeline = commentString:gsub('%%s', modelineConcat) -- Place modeline in commentstring correctly

  return modeline
end

-- Insert modeline in buffer
function insertModeline()
  local modeline = generateModeline()
  local buffer = api.nvim_win_get_buf(0)
  local last_line_index = api.nvim_buf_line_count(buffer) - 1
  local last_line = api.nvim_buf_get_lines(buffer, last_line_index, last_line_index + 1, true)[1]

  if last_line == modeline then
    -- modeline already exists at end, do nothing
  elseif last_line and last_line:match 'vim:' then
    -- different modeline exists at end, replace
    api.nvim_buf_set_lines(buffer, last_line_index, last_line_index + 1, true, { modeline })
    print 'Changed modeline.'
  else
    -- no modeline exists at end, append
    api.nvim_buf_set_lines(buffer, last_line_index + 1, last_line_index + 1, true, { modeline })
    print 'Inserted modeline.'
  end
end
