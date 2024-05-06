local M ={}

function M.CreateOpenFile(template,newFileName)
  -- Get the name of the current buffer
  local current_buffer_name = vim.api.nvim_buf_get_name(0)

  -- Extract the directory path from the buffer name
  local current_directory = current_buffer_name:match("(.*[/\\])")

  -- Prompt the user for the name of the new file
  local newFile = current_directory .."/figures/" .. newFileName

  -- Create a new file based on a template
  CreateFile(template, newFile)

  -- Open the new file
  OpenFile(newFile)
end

function M.RelativePath()
  -- Get the name of the current buffer
  local buffer_name = vim.api.nvim_buf_get_name(0)

  -- Get the directory of the current buffer
  local buffer_directory = vim.fn.fnamemodify(buffer_name, ":h")

  -- Get the current working directory
  local working_directory = vim.fn.getcwd()

  -- Calculate the relative path
  local relative_path = vim.fn.relpath(buffer_directory, working_directory)

  return relative_path
end

function M.PrintFigure(fileName)
  local buf = vim.api.nvim_get_current_buf()

  local current_win = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(current_win)
  local current_line = cursor[1]
  print(current_line)
  -- Set the new text for the entire buffer
  local my_text ={
      '\\begin{figure}[h]',
      '    \\centering',
      '    \\includesvg[width=0.8\\textwidth]{'.. fileName ..'}',
      '\\end{figure}'
    }
  vim.api.nvim_buf_set_lines(buf, current_line-1, current_line,  false, my_text)
end

return M
