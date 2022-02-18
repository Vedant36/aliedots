#!/usr/bin/env lua

-- wrapper function for the occasion when the module is not present
function check(name)
    local ok, module = pcall(require, name)
    if ok then
        return module
    else
        return {setup=function() end, ok=ok}
    end
end

