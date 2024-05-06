local M = {}

-- I gave up on multifile one
-- local func = require("inking-latex.functions")

function M.CreateFile(template,filename)
  -- os.execute("cp \"" .. template .. " " .. filename)
  os.execute("cp ".. template .. " "  .. filename )
end

function M.OpenFile(file)
  os.execute("open " .. file)
end

function M.CreateOpenFile(template,newFileName)
  -- Get the name of the current buffer
  local current_buffer_name = vim.api.nvim_buf_get_name(0)

  -- Extract the directory path from the buffer name
  local current_directory = current_buffer_name:match("(.*[/\\])")

  -- Prompt the user for the name of the new file
  local newFile = current_directory .."/figures/" .. newFileName

  -- Create a new file based on a template
  M.CreateFile(template, newFile)

  -- Open the new file
  M.OpenFile(newFile)
end

-- function M.RelativePath()
--   -- Get the name of the current buffer
--   local buffer_name = vim.api.nvim_buf_get_name(0)
--
--   -- Get the directory of the current buffer
--   local buffer_directory = vim.fn.fnamemodify(buffer_name, ":h")
--
--   -- Get the current working directory
--   local working_directory = vim.fn.getcwd()
--
--   -- Calculate the relative path
--   local relative_path = vim.fn.relpath(buffer_directory, working_directory)
--
--   return relative_path
-- end

function M.RelativePath()
-- Get the full path of the buffer
local buffer_path = vim.api.nvim_buf_get_name(0)

-- Extract the directory portion of the buffer's path
local buffer_directory = vim.fn.fnamemodify(buffer_path, ':h')

-- Get the current working directory
local working_directory = vim.fn.getcwd()

-- Compute the relative path
local relative_path = vim.fn.fnamemodify(buffer_directory, ':~:.') -- Compute the relative path
end


function M.removeFinalDirectory(path)
    -- Find the last directory separator
    local lastSeparator = path:match(".+[/\\]([^/\\]+)$")

    if lastSeparator then
        -- Remove the last directory and the separator
        return path:sub(1, -(#lastSeparator + 2))
    else
        -- If no directory separator is found, return the input path
        return path
    end
end

function M.GetRelativePath()
  local relpath = vim.fn.expand('%:.')
  local bufname = vim.fn.expand('%')
  local relative_path = string.sub(relpath,1,-1 -string.len(bufname))
  return relative_path

end

function M.PrintFigure(fileName)
  local buf = vim.api.nvim_get_current_buf()

  local current_win = vim.api.nvim_get_current_win()
  local cursor = vim.api.nvim_win_get_cursor(current_win)
  local current_line = cursor[1]

  local relative_path = M.GetRelativePath()
  print({vim.fn.expand('%:.'), vim.fn.expand('%'), relative_path})
    -- Set the new text for the entire buffer
  local my_text ={
      '\\begin{figure}[h]',
      '    \\centering',
      '    \\includesvg[width=0.8\\textwidth]{'..relative_path..'figures/' .. fileName ..'}',
      '    \\caption{}',
      '    \\label{fig:'..string.sub(fileName,1,-5)..'}',
      '\\end{figure}'
    }
  vim.api.nvim_buf_set_lines(buf, current_line-1, current_line,  false, my_text)
end


function M.CreateFigure()
  local working_directory = vim.fn.getcwd()
  local template = working_directory .."/figures/template.svg"
  -- print(template)

  local newFileName= vim.fn.input("Enter the name for the new file (no extension): ") .. ".svg"

  M.CreateOpenFile(template,newFileName)
  M.PrintFigure(newFileName)
  end

return M


