vim.cmd("highlight clear")

if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "expedition33"

local p = {
  void = "#020303",
  mantle = "#070809",
  surface = "#0d0f10",
  surface2 = "#151718",
  line = "#26231e",
  overlay = "#3b352b",
  muted = "#6f6a5f",
  subtle = "#a9a394",
  text = "#d8d0bd",
  bright = "#f3ead4",
  gold = "#c6a15b",
  amber = "#d8b86f",
  blue = "#9b9488",
  cyan = "#a49a86",
  teal = "#888b82",
  green = "#8fa77b",
  red = "#b7504d",
  crimson = "#d06059",
  rose = "#a88c82",
  mauve = "#938b82",
  violet = "#817b72",
  none = "NONE",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function link(group, target)
  hl(group, { link = target })
end

local function semantic(name, opts)
  hl("@lsp." .. name, opts)
end

local function semantic_link(name, target)
  link("@lsp." .. name, target)
end

local styles = {
  bold = true,
  italic = false,
  undercurl = true,
}

hl("Normal", { fg = p.text, bg = p.void })
hl("NormalNC", { fg = p.muted, bg = p.void })
hl("NormalFloat", { fg = p.text, bg = p.mantle })
hl("FloatBorder", { fg = p.overlay, bg = p.mantle })
hl("FloatTitle", { fg = p.gold, bg = p.mantle, bold = true })
hl("ColorColumn", { bg = p.mantle })
hl("Conceal", { fg = p.muted })
hl("Cursor", { fg = p.void, bg = p.amber })
hl("lCursor", { fg = p.void, bg = p.amber })
hl("CursorIM", { fg = p.void, bg = p.amber })
hl("CursorLine", { bg = p.surface })
hl("CursorColumn", { bg = p.surface })
hl("Directory", { fg = p.subtle })
hl("EndOfBuffer", { fg = p.void })
hl("ErrorMsg", { fg = p.red, bold = true })
hl("VertSplit", { fg = p.line, bg = p.none })
hl("WinSeparator", { fg = p.line, bg = p.none })
hl("Folded", { fg = p.muted, bg = p.surface })
hl("FoldColumn", { fg = p.overlay, bg = p.void })
hl("SignColumn", { fg = p.subtle, bg = p.void })
hl("IncSearch", { fg = p.void, bg = p.amber })
hl("CurSearch", { fg = p.void, bg = p.gold, bold = true })
hl("Substitute", { fg = p.void, bg = p.crimson })
hl("LineNr", { fg = p.overlay })
hl("CursorLineNr", { fg = p.gold, bold = true })
hl("MatchParen", { fg = p.gold, bg = p.surface2, bold = true })
hl("ModeMsg", { fg = p.gold, bold = true })
hl("MoreMsg", { fg = p.gold })
hl("NonText", { fg = p.overlay })
hl("Pmenu", { fg = p.text, bg = p.mantle })
hl("PmenuSel", { fg = p.void, bg = p.gold })
hl("PmenuKind", { fg = p.gold, bg = p.mantle })
hl("PmenuKindSel", { fg = p.void, bg = p.gold })
hl("PmenuExtra", { fg = p.muted, bg = p.mantle })
hl("PmenuExtraSel", { fg = p.void, bg = p.gold })
hl("PmenuSbar", { bg = p.surface2 })
hl("PmenuThumb", { bg = p.overlay })
hl("Question", { fg = p.gold })
hl("QuickFixLine", { bg = p.surface2, bold = true })
hl("Search", { fg = p.void, bg = p.gold })
hl("SpecialKey", { fg = p.overlay })
hl("SpellBad", { sp = p.red, undercurl = styles.undercurl })
hl("SpellCap", { sp = p.gold, undercurl = styles.undercurl })
hl("SpellLocal", { sp = p.subtle, undercurl = styles.undercurl })
hl("SpellRare", { sp = p.subtle, undercurl = styles.undercurl })
hl("TabLine", { fg = p.muted, bg = p.void })
hl("TabLineFill", { bg = p.void })
hl("TabLineSel", { fg = p.gold, bg = p.surface, bold = true })
hl("Title", { fg = p.gold, bold = true })
hl("Visual", { bg = p.surface2 })
hl("VisualNOS", { bg = p.surface2 })
hl("WarningMsg", { fg = p.gold })
hl("Whitespace", { fg = p.overlay })
hl("WildMenu", { fg = p.void, bg = p.gold })

hl("Comment", { fg = p.muted })
hl("Constant", { fg = p.subtle })
hl("String", { fg = p.green })
hl("Character", { fg = p.green })
hl("Number", { fg = p.subtle })
hl("Boolean", { fg = p.gold, bold = styles.bold })
hl("Float", { fg = p.subtle })
hl("Identifier", { fg = p.text })
hl("Function", { fg = p.text })
hl("Statement", { fg = p.subtle })
hl("Conditional", { fg = p.subtle })
hl("Repeat", { fg = p.subtle })
hl("Label", { fg = p.gold })
hl("Operator", { fg = p.subtle })
hl("Keyword", { fg = p.subtle })
hl("Exception", { fg = p.red })
hl("PreProc", { fg = p.subtle })
hl("Include", { fg = p.subtle })
hl("Define", { fg = p.gold })
hl("Macro", { fg = p.gold })
hl("PreCondit", { fg = p.subtle })
hl("Type", { fg = p.gold })
hl("StorageClass", { fg = p.gold })
hl("Structure", { fg = p.gold })
hl("Typedef", { fg = p.gold })
hl("Special", { fg = p.gold })
hl("SpecialChar", { fg = p.gold })
hl("Tag", { fg = p.subtle })
hl("Delimiter", { fg = p.subtle })
hl("SpecialComment", { fg = p.muted })
hl("Debug", { fg = p.red })
hl("Underlined", { fg = p.gold, underline = true })
hl("Ignore", { fg = p.muted })
hl("Error", { fg = p.red })
hl("Todo", { fg = p.gold, bg = p.mantle, bold = true })

hl("DiagnosticError", { fg = p.red })
hl("DiagnosticWarn", { fg = p.gold })
hl("DiagnosticInfo", { fg = p.subtle })
hl("DiagnosticHint", { fg = p.subtle })
hl("DiagnosticOk", { fg = p.subtle })
hl("DiagnosticVirtualTextError", { fg = p.red, bg = p.mantle })
hl("DiagnosticVirtualTextWarn", { fg = p.gold, bg = p.mantle })
hl("DiagnosticVirtualTextInfo", { fg = p.subtle, bg = p.mantle })
hl("DiagnosticVirtualTextHint", { fg = p.subtle, bg = p.mantle })
hl("DiagnosticVirtualTextOk", { fg = p.subtle, bg = p.mantle })
hl("DiagnosticUnderlineError", { sp = p.red, underline = true })
hl("DiagnosticUnderlineWarn", { sp = p.gold, underline = true })
hl("DiagnosticUnderlineInfo", { sp = p.subtle, underline = true })
hl("DiagnosticUnderlineHint", { sp = p.subtle, underline = true })
hl("DiagnosticUnderlineOk", { sp = p.subtle, underline = true })
link("DiagnosticFloatingError", "DiagnosticError")
link("DiagnosticFloatingWarn", "DiagnosticWarn")
link("DiagnosticFloatingInfo", "DiagnosticInfo")
link("DiagnosticFloatingHint", "DiagnosticHint")
link("DiagnosticFloatingOk", "DiagnosticOk")
link("DiagnosticSignError", "DiagnosticError")
link("DiagnosticSignWarn", "DiagnosticWarn")
link("DiagnosticSignInfo", "DiagnosticInfo")
link("DiagnosticSignHint", "DiagnosticHint")
link("DiagnosticSignOk", "DiagnosticOk")

hl("LspReferenceText", { bg = p.surface })
hl("LspReferenceRead", { bg = p.surface })
hl("LspReferenceWrite", { bg = p.surface2 })
hl("LspSignatureActiveParameter", { fg = p.gold, bg = p.surface2, bold = true })
hl("LspInlayHint", { fg = p.muted, bg = p.mantle })
hl("SnippetTabstop", { fg = p.gold, bg = p.surface2 })

link("@annotation", "PreProc")
link("@attribute", "PreProc")
link("@boolean", "Boolean")
link("@character", "Character")
link("@character.special", "SpecialChar")
link("@comment", "Comment")
link("@comment.error", "DiagnosticError")
link("@comment.hint", "DiagnosticHint")
link("@comment.info", "DiagnosticInfo")
link("@comment.note", "DiagnosticInfo")
link("@comment.todo", "Todo")
link("@comment.warning", "DiagnosticWarn")
link("@constant", "Constant")
link("@constant.builtin", "Special")
link("@constant.macro", "Define")
link("@constructor", "Special")
link("@diff.delta", "DiffChange")
link("@diff.minus", "DiffDelete")
link("@diff.plus", "DiffAdd")
link("@function", "Function")
link("@function.builtin", "Special")
link("@function.call", "Function")
link("@function.macro", "Macro")
link("@function.method", "Function")
link("@function.method.call", "Function")
link("@keyword", "Keyword")
link("@keyword.conditional", "Conditional")
link("@keyword.coroutine", "Keyword")
link("@keyword.debug", "Debug")
link("@keyword.directive", "PreProc")
link("@keyword.directive.define", "Define")
link("@keyword.exception", "Exception")
link("@keyword.function", "Keyword")
link("@keyword.import", "Include")
link("@keyword.operator", "Operator")
link("@keyword.repeat", "Repeat")
link("@keyword.return", "Keyword")
link("@keyword.storage", "StorageClass")
link("@label", "Label")
link("@markup", "Normal")
link("@markup.emphasis", "Italic")
link("@markup.environment", "Macro")
link("@markup.environment.name", "Type")
link("@markup.heading", "Title")
link("@markup.heading.1", "Title")
link("@markup.heading.2", "Title")
link("@markup.italic", "Italic")
link("@markup.link", "Underlined")
link("@markup.link.label", "Special")
link("@markup.link.url", "Underlined")
link("@markup.list", "Delimiter")
link("@markup.list.checked", "DiagnosticOk")
link("@markup.list.unchecked", "DiagnosticHint")
link("@markup.math", "Special")
link("@markup.quote", "Comment")
link("@markup.raw", "String")
link("@markup.raw.block", "String")
link("@markup.strikethrough", "Strikethrough")
link("@markup.strong", "Bold")
link("@markup.underline", "Underlined")
link("@module", "Include")
link("@module.builtin", "Special")
link("@namespace", "Include")
link("@none", "Normal")
link("@number", "Number")
link("@number.float", "Float")
link("@operator", "Operator")
link("@property", "Identifier")
link("@punctuation.bracket", "Delimiter")
link("@punctuation.delimiter", "Delimiter")
link("@punctuation.special", "Special")
link("@string", "String")
link("@string.documentation", "String")
link("@string.escape", "SpecialChar")
link("@string.regexp", "SpecialChar")
link("@string.special", "SpecialChar")
link("@string.special.path", "Directory")
link("@string.special.symbol", "Special")
link("@string.special.url", "Underlined")
link("@tag", "Tag")
link("@tag.attribute", "Identifier")
link("@tag.delimiter", "Delimiter")
link("@type", "Type")
link("@type.builtin", "Type")
link("@type.definition", "Typedef")
link("@type.qualifier", "StorageClass")
link("@variable", "Identifier")
link("@variable.builtin", "Special")
link("@variable.member", "Identifier")
link("@variable.parameter", "Identifier")
link("@variable.parameter.builtin", "Special")

hl("Bold", { bold = true })
hl("Italic", { italic = styles.italic })
hl("Strikethrough", { strikethrough = true })

semantic_link("type.namespace", "Include")
semantic_link("type.type", "Type")
semantic_link("type.class", "Type")
semantic_link("type.enum", "Type")
semantic_link("type.interface", "Type")
semantic_link("type.struct", "Structure")
semantic_link("type.typeParameter", "Type")
semantic_link("type.parameter", "Identifier")
semantic_link("type.variable", "Identifier")
semantic_link("type.property", "Identifier")
semantic_link("type.enumMember", "Constant")
semantic_link("type.event", "Special")
semantic_link("type.function", "Function")
semantic_link("type.method", "Function")
semantic_link("type.macro", "Macro")
semantic_link("type.keyword", "Keyword")
semantic_link("type.modifier", "StorageClass")
semantic_link("type.comment", "Comment")
semantic_link("type.string", "String")
semantic_link("type.number", "Number")
semantic_link("type.regexp", "SpecialChar")
semantic_link("type.operator", "Operator")
semantic_link("type.decorator", "PreProc")
semantic("mod.declaration", { bold = true })
semantic("mod.definition", { bold = true })
semantic("mod.readonly", { fg = p.subtle })
semantic("mod.static", { fg = p.gold })
semantic("mod.deprecated", { fg = p.muted, strikethrough = true })
semantic("mod.abstract", { fg = p.subtle })
semantic("mod.async", { fg = p.subtle })
semantic("mod.modification", { fg = p.gold })
semantic("mod.documentation", { fg = p.muted })
semantic("mod.defaultLibrary", { fg = p.subtle })
semantic("mod.globalScope", { fg = p.bright })
semantic("typemod.class.defaultLibrary", { fg = p.gold })
semantic("typemod.enum.defaultLibrary", { fg = p.gold })
semantic("typemod.enumMember.defaultLibrary", { fg = p.subtle })
semantic("typemod.function.defaultLibrary", { fg = p.subtle })
semantic("typemod.function.async", { fg = p.subtle })
semantic("typemod.function.declaration", { fg = p.text, bold = true })
semantic("typemod.function.definition", { fg = p.text, bold = true })
semantic("typemod.interface.defaultLibrary", { fg = p.gold })
semantic("typemod.macro.defaultLibrary", { fg = p.gold })
semantic("typemod.method.defaultLibrary", { fg = p.subtle })
semantic("typemod.method.async", { fg = p.subtle })
semantic("typemod.method.declaration", { fg = p.text, bold = true })
semantic("typemod.method.definition", { fg = p.text, bold = true })
semantic("typemod.namespace.defaultLibrary", { fg = p.subtle })
semantic("typemod.parameter.readonly", { fg = p.subtle })
semantic("typemod.property.readonly", { fg = p.subtle })
semantic("typemod.property.static", { fg = p.gold })
semantic("typemod.struct.defaultLibrary", { fg = p.gold })
semantic("typemod.type.defaultLibrary", { fg = p.gold })
semantic("typemod.typeParameter.defaultLibrary", { fg = p.gold })
semantic("typemod.variable.defaultLibrary", { fg = p.subtle })
semantic("typemod.variable.globalScope", { fg = p.bright })
semantic("typemod.variable.readonly", { fg = p.subtle })
semantic("typemod.variable.static", { fg = p.gold })

hl("DiffAdd", { fg = p.green, bg = "#12180f" })
hl("DiffChange", { fg = p.subtle, bg = "#151311" })
hl("DiffDelete", { fg = p.red, bg = "#1b0e0d" })
hl("DiffText", { fg = p.gold, bg = "#241d10", bold = true })
hl("Added", { fg = p.green })
hl("Changed", { fg = p.subtle })
hl("Removed", { fg = p.red })

hl("GitSignsAdd", { fg = p.green })
hl("GitSignsChange", { fg = p.subtle })
hl("GitSignsDelete", { fg = p.red })
hl("GitSignsCurrentLineBlame", { fg = p.muted })

hl("TelescopeBorder", { fg = p.overlay, bg = p.mantle })
hl("TelescopeNormal", { fg = p.text, bg = p.mantle })
hl("TelescopePromptBorder", { fg = p.gold, bg = p.mantle })
hl("TelescopePromptNormal", { fg = p.bright, bg = p.mantle })
hl("TelescopePromptPrefix", { fg = p.gold })
hl("TelescopeSelection", { fg = p.bright, bg = p.surface2 })
hl("TelescopeMatching", { fg = p.gold, bold = true })

hl("FlashLabel", { fg = p.void, bg = p.gold, bold = true })
hl("FlashCurrent", { bg = p.surface2 })
hl("FlashMatch", { fg = p.gold, bold = true })

hl("MiniIndentscopeSymbol", { fg = p.overlay })
hl("MiniJump", { fg = p.void, bg = p.gold })
hl("MiniJump2dSpot", { fg = p.gold, bold = true })
hl("MiniStatuslineModeNormal", { fg = p.void, bg = p.gold })
hl("MiniStatuslineModeInsert", { fg = p.void, bg = p.amber })
hl("MiniStatuslineModeVisual", { fg = p.void, bg = p.subtle })
hl("MiniStatuslineModeReplace", { fg = p.void, bg = p.red })
hl("MiniStatuslineModeCommand", { fg = p.void, bg = p.gold })

hl("OilDir", { fg = p.subtle })
hl("OilDirIcon", { fg = p.gold })
hl("OilFile", { fg = p.text })
hl("OilLink", { fg = p.gold })
hl("OilSocket", { fg = p.subtle })
hl("OilCreate", { fg = p.gold })
hl("OilDelete", { fg = p.red })
hl("OilMove", { fg = p.subtle })
hl("OilChange", { fg = p.subtle })

hl("StatusLine", { fg = p.text, bg = p.void })
hl("StatusLineNC", { fg = p.muted, bg = p.void })
hl("Expedition33ModeNormal", { fg = p.void, bg = p.gold, bold = true })
hl("Expedition33ModeInsert", { fg = p.void, bg = p.green, bold = true })
hl("Expedition33ModeCommand", { fg = p.void, bg = p.red, bold = true })
hl("Expedition33ModeVisual", { fg = p.void, bg = p.subtle, bold = true })
hl("Expedition33ModeReplace", { fg = p.void, bg = p.crimson, bold = true })
hl("Expedition33ModeTerminal", { fg = p.void, bg = p.amber, bold = true })
hl("User1", { fg = p.void, bg = p.gold, bold = true })
hl("User2", { fg = p.subtle, bg = p.void })
hl("User3", { fg = p.red, bg = p.void })
hl("User4", { fg = p.gold, bg = p.void })
hl("User5", { fg = p.gold, bg = p.void })
hl("User6", { fg = p.muted, bg = p.void })
hl("User7", { fg = p.gold, bg = p.void })
hl("User8", { fg = p.subtle, bg = p.void })
hl("User9", { fg = p.subtle, bg = p.void })

vim.g.terminal_color_0 = p.void
vim.g.terminal_color_1 = p.red
vim.g.terminal_color_2 = p.green
vim.g.terminal_color_3 = p.gold
vim.g.terminal_color_4 = p.blue
vim.g.terminal_color_5 = p.mauve
vim.g.terminal_color_6 = p.cyan
vim.g.terminal_color_7 = p.text
vim.g.terminal_color_8 = p.overlay
vim.g.terminal_color_9 = p.crimson
vim.g.terminal_color_10 = p.green
vim.g.terminal_color_11 = p.amber
vim.g.terminal_color_12 = p.blue
vim.g.terminal_color_13 = p.rose
vim.g.terminal_color_14 = p.teal
vim.g.terminal_color_15 = p.bright

local mode_names = {
  n = "N",
  no = "O",
  nov = "O",
  noV = "O",
  ["no\022"] = "O",
  niI = "N",
  niR = "N",
  niV = "N",
  nt = "N",
  v = "V",
  vs = "V",
  V = "VL",
  Vs = "VL",
  ["\022"] = "VB",
  ["\022s"] = "VB",
  s = "S",
  S = "SL",
  ["\019"] = "SB",
  i = "I",
  ic = "I",
  ix = "I",
  R = "R",
  Rc = "R",
  Rx = "R",
  Rv = "RV",
  Rvc = "RV",
  Rvx = "RV",
  c = "C",
  cv = "EX",
  r = "P",
  rm = "M",
  ["r?"] = "?",
  ["!"] = "!",
  t = "T",
}

_G.Expedition33Statusline = {
  mode = function()
    return mode_names[vim.api.nvim_get_mode().mode] or "?"
  end,
  mode_segment = function()
    local mode = vim.api.nvim_get_mode().mode
    local name = mode_names[mode] or "?"
    local group = "Expedition33ModeNormal"
    if mode:match("^[i]") then
      group = "Expedition33ModeInsert"
    elseif mode:match("^[R]") then
      group = "Expedition33ModeReplace"
    elseif mode:match("^[c]") or mode == "!" then
      group = "Expedition33ModeCommand"
    elseif mode:match("^[vVs\022\019]") then
      group = "Expedition33ModeVisual"
    elseif mode == "t" then
      group = "Expedition33ModeTerminal"
    end
    return "%#" .. group .. "# " .. name .. " %*"
  end,
  filetype = function()
    return vim.bo.filetype ~= "" and vim.bo.filetype or "no ft"
  end,
  diagnostics = function()
    local counts = vim.diagnostic.count and vim.diagnostic.count(0) or {}
    if not vim.diagnostic.count then
      for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
        counts[diagnostic.severity] = (counts[diagnostic.severity] or 0) + 1
      end
    end
    local err = counts[vim.diagnostic.severity.ERROR] or 0
    local warn = counts[vim.diagnostic.severity.WARN] or 0
    local info = counts[vim.diagnostic.severity.INFO] or 0
    local hint = counts[vim.diagnostic.severity.HINT] or 0
    local parts = {}
    if err > 0 then
      parts[#parts + 1] = "E" .. err
    end
    if warn > 0 then
      parts[#parts + 1] = "W" .. warn
    end
    if info > 0 then
      parts[#parts + 1] = "I" .. info
    end
    if hint > 0 then
      parts[#parts + 1] = "H" .. hint
    end
    return #parts > 0 and table.concat(parts, " ") or ""
  end,
}

vim.o.laststatus = 3
vim.o.statusline = table.concat({
  "%{%v:lua.Expedition33Statusline.mode_segment()%}",
  "%2* %<%f%*",
  "%3*%m%r%h%w%*",
  "%=",
  "%3*%{v:lua.Expedition33Statusline.diagnostics()}%*",
  "%8* %{v:lua.Expedition33Statusline.filetype()}%*",
  "%6* %l/%L:%c %*",
  "%5* 0x%04B %*",
})
