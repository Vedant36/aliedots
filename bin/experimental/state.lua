#!/usr/bin/env lua
-- Rewrite of bin/scripts/state, probably
-- Script to handle states of programs
--[[
future default command template:
display: shows number of processes with the exact name "$cmd"
  pgrep -xc "$cmd"
command_exists:
  command -v "$cmd" >/dev/null
test_for_on:
  pgrep -x "$cmd" >/dev/null
turn_off:
  pkill -x "$cmd"
turn_on:
  exec "$cmd" "$@" &
toggle:
  if $test_for_on; then
    $turn_off
  else
    $command_exists && $turn_on
  fi
]]

M = {}
function M.config()
end
function M:is_on()
end
function M:turn_off()
end
function M:command_exists()
end
function M:turn_on()
end
function M:toggle()
  if self:is_on() then
    self:turn_off()
  else
    if self:command_exists() then self:turn_on() end
  end
end
return M
