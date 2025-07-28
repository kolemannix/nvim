local P = {}

-- Private state
local compile_buf = nil
local compile_win = nil
local command_history = {}

function P.reset()
  compile_buf = nil
  compile_win = nil
  command_history = {}
end

-- Get the current compile buffer if it exists and is valid
local function get_compile_buffer()
  if compile_buf and vim.api.nvim_buf_is_valid(compile_buf) then
    return compile_buf
  end

  -- Find a buffer named *compile*
  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) == "*compile*" then
      compile_buf = buf
      return compile_buf
    end
  end

  compile_buf = nil
  return nil
end

-- Check if compile buffer is currently visible in any window
local function find_compile_window()
  local buf = get_compile_buffer()
  if not buf then return nil end

  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return win
    end
  end
  return nil
end

-- Create or show the compile terminal window
local function ensure_compile_window()
  local buf = get_compile_buffer()
  local win = find_compile_window()

  if buf and win then
    -- Buffer and window both exist
    compile_win = win
    return buf, win
  elseif buf and not win then
    -- Buffer exists but not visible, open it in a split
    vim.cmd("below split")
    compile_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(compile_win, buf)
    return buf, compile_win
  else
    -- Create new terminal buffer
    vim.cmd("below term")
    compile_buf = vim.api.nvim_get_current_buf()
    compile_win = vim.api.nvim_get_current_win()

    -- Set buffer name for easy identification
    vim.api.nvim_buf_set_name(compile_buf, "*compile*")

    return compile_buf, compile_win
  end
end

-- Send command to the compile terminal
local function send_command(cmd, focus)
  local buf, win = ensure_compile_window()

  -- Focus the compile window
  if focus then vim.api.nvim_set_current_win(win) end

  -- Add to history (dedupe first)
  for i, existing_cmd in ipairs(command_history) do
    if existing_cmd == cmd then
      table.remove(command_history, i)
      break
    end
  end
  table.insert(command_history, 1, cmd)
  if #command_history > 20 then
    table.remove(command_history)
  end

  -- Send command to terminal
  local chan = vim.bo[buf].channel
  if chan > 0 then
    vim.api.nvim_chan_send(chan, cmd .. "\n")
  else
    -- Terminal not ready yet, try after delay
    vim.defer_fn(function()
      local chan = vim.bo[buf].channel
      if chan > 0 then
        vim.api.nvim_chan_send(chan, cmd .. "\n")
      end
    end, 100)
  end
end

-- Helper function for command input with completion
local function prompt_for_command()
  vim.ui.input({
    prompt = "Command: ",
    completion = "shellcmd"
  }, function(input_cmd)
    if input_cmd and input_cmd ~= "" then
      send_command(input_cmd, true)
    end
  end)
end

function P.command()
  P.compile(false)
end

-- Main compile function - run command in persistent terminal
function P.compile(hist)
  if #command_history == 0 then
    prompt_for_command()
    return
  end

  if not hist then
    prompt_for_command()
    return
  end

  -- Show history selection with "new" option
  local options = { "new..." }
  for _, hist_cmd in ipairs(command_history) do
    table.insert(options, hist_cmd)
  end

  vim.ui.select(options, {
    prompt = "Select command: ",
    format_item = function(item)
      return item == "new..." and "→ " .. item or item
    end,
  }, function(choice)
    if choice == "new..." then
      prompt_for_command()
    elseif choice then
      send_command(choice, true)
    end
  end)
end

function P.get_history()
  return vim.deepcopy(command_history)
end

function P.recompile()
  if #command_history > 0 then
    send_command(command_history[1], false)
  else
    P.compile() -- Prompt for command if no history
  end
end

-- Close compile window but keep buffer
function P.close_window()
  local win = find_compile_window()
  if win then
    vim.api.nvim_win_close(win, false)
  end
end

-- Toggle compile window visibility
function P.toggle_window()
  local win = find_compile_window()
  if win then
    -- Window is visible, close it
    vim.api.nvim_win_close(win, false)
  else
    -- Window is not visible, show it
    local buf = get_compile_buffer()
    if buf then
      -- Buffer exists, open it in a split
      vim.cmd("below split")
      compile_win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_buf(compile_win, buf)
    else
      -- No buffer exists, create new terminal
      ensure_compile_window()
    end
  end
end

-- Scroll to bottom of compile buffer
function P.scroll_to_bottom()
  local buf = get_compile_buffer()
  if not buf then
    -- NOTE(scroll_to_bottom): No compile buffer exists, nothing to scroll
    return
  end
  
  local win = find_compile_window()
  if not win then
    -- NOTE(scroll_to_bottom): Compile buffer exists but not visible, should we open it?
    return
  end
  
  -- Get the total number of lines in the buffer
  local line_count = vim.api.nvim_buf_line_count(buf)
  
  -- Set cursor to the last line
  vim.api.nvim_win_set_cursor(win, {line_count, 0})
end

vim.api.nvim_create_user_command('C', function(opts)
  local cmd = opts.args
  if cmd and cmd ~= "" then
    send_command(cmd, true)
  else
    P.compile(false)
  end
end, {
  nargs = '*', -- Accept any number of arguments
  complete = 'shellcmd', -- Enable shell command completion
  desc = 'Run command in compile terminal'
})

return P
