#!/usr/bin/env lua

-- short name funciton for pretty print
_G.put=vim.pretty_print
-- wrapper function for the occasion when the module is not present
function check(name)
    local ok, module = pcall(require, name)
    if ok then
        return module
    else
        return {setup=function() end}
    end

end

require("vn36.options")

