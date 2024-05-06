local M = {}

local func = require("inking-latex.functions")

-- get template location; should be located in a figures folder in the main directory called template
local working_directory = vim.fn.getcwd()
local template = working_directory .."/figures/template.svg"

function M.CreateFigure()
  io.write("Enter the name for the new file (no extension): ")
  local newFileName = io.read() .. ".svg"
  func.CreateOpenFile(template,newFileName)

  func.PrintFigure(newFileName)
end

return M

