local M = {}

local func = require("inking-latex.functions")

-- get template location; should be located in a figures folder in the main directory called template


function M.CreateFigure()

  local working_directory = vim.fn.getcwd()
  local template = working_directory .."/figures/template.svg"
  -- print(template)

  local newFileName= vim.fn.input("Enter the name for the new file (no extension): ") .. ".svg"

  func.CreateOpenFile(template,newFileName)

end

return M
