local M = {}

local function hl(group_name)
    return vim.api.nvim_get_hl(0, { name = group_name })
end

function M.set_highlights()
    local sl_bg = hl("CursorColumn").bg

    local highlights = {
        -- Split border
        { "WinSeparator", { fg = hl("CursorColumn").bg } },

        -- Statusline base
        { "StatusLine", { fg = hl("CursorColumn").fg, bg = sl_bg } },

        -- Mode pills (colored fg, statusline bg)
        { "SLModeNormal",   { fg = hl("Function").fg,        bg = sl_bg, bold = true } },
        { "SLModeInsert",   { fg = hl("String").fg,          bg = sl_bg, bold = true } },
        { "SLModeVisual",   { fg = hl("Special").fg,         bg = sl_bg, bold = true } },
        { "SLModeReplace",  { fg = hl("DiagnosticError").fg, bg = sl_bg, bold = true } },
        { "SLModeCommand",  { fg = hl("DiagnosticWarn").fg,  bg = sl_bg, bold = true } },
        { "SLModeTerminal", { fg = hl("DiagnosticInfo").fg,  bg = sl_bg, bold = true } },

        -- Left section
        { "SLBranch",    { fg = hl("Comment").fg,       bg = sl_bg } },
        { "SLFilename",  { fg = hl("Normal").fg,        bg = sl_bg } },
        { "SLModified",  { fg = hl("DiagnosticWarn").fg, bg = sl_bg } },
        { "SLUnmodified", { fg = hl("Comment").fg,      bg = sl_bg } },

        -- Right section
        { "SLFileSize", { fg = hl("Comment").fg, bg = sl_bg } },
        { "SLFiletype", { fg = sl_bg, bg = hl("Type").fg, bold = true } },
        { "SLDiagOk",   { fg = hl("DiagnosticHint").fg, bg = sl_bg } },
        { "SLDiagError", { fg = hl("DiagnosticError").fg, bg = sl_bg } },
        { "SLDiagWarn",  { fg = hl("DiagnosticWarn").fg,  bg = sl_bg } },
        { "SLPosition",  { fg = sl_bg, bg = hl("Keyword").fg, bold = true } },
        { "SLLspStatus", { fg = hl("Comment").fg, bg = sl_bg } },

        -- Blink CMP
        { "BlinkCmpMenu",       { bg = hl("Normal").bg } },
        { "BlinkCmpMenuBorder", { bg = hl("Normal").bg } },
        { "BlinkCmpKind",       { bg = hl("Normal").bg } },
    }

    for _, highlight in ipairs(highlights) do
        vim.api.nvim_set_hl(0, highlight[1], highlight[2])
    end
end

M.set_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = M.set_highlights,
})

return M
