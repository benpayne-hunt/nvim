local current_mode = ""
local current_file_path = ""
local current_lsp_status = ""

local mode_hls = {
    ["n"]   = "SLModeNormal",
    ["no"]  = "SLModeNormal",
    ["v"]   = "SLModeVisual",
    ["V"]   = "SLModeVisual",
    ["\22"] = "SLModeVisual",
    ["s"]   = "SLModeVisual",
    ["S"]   = "SLModeVisual",
    ["\19"] = "SLModeVisual",
    ["i"]   = "SLModeInsert",
    ["ic"]  = "SLModeInsert",
    ["R"]   = "SLModeReplace",
    ["Rv"]  = "SLModeReplace",
    ["c"]   = "SLModeCommand",
    ["cv"]  = "SLModeCommand",
    ["t"]   = "SLModeTerminal",
}

local mode_names = {
    ["n"]   = "NORMAL",
    ["no"]  = "PENDING",
    ["v"]   = "VISUAL",
    ["V"]   = "V-LINE",
    ["\22"] = "V-BLOCK",
    ["s"]   = "SELECT",
    ["S"]   = "S-LINE",
    ["\19"] = "S-BLOCK",
    ["i"]   = "INSERT",
    ["ic"]  = "INSERT",
    ["R"]   = "REPLACE",
    ["Rv"]  = "V-REPLACE",
    ["c"]   = "COMMAND",
    ["cv"]  = "COMMAND",
    ["t"]   = "TERMINAL",
}

local function set_mode()
    local mode = vim.api.nvim_get_mode().mode
    local hl = mode_hls[mode] or "SLModeNormal"
    local name = mode_names[mode] or mode:upper()
    current_mode = "%#" .. hl .. "# ● " .. name .. " %*"
end

local function set_filepath()
    local path = vim.fn.expand("%:~:.")
    current_file_path = path
end

local lsp_status_timer = nil

local function set_lsp_status()
    local status = vim.lsp.status()

    if lsp_status_timer then
        lsp_status_timer:stop()
        lsp_status_timer = nil
    end

    if status == "" then
        current_lsp_status = ""
    else
        current_lsp_status = "%#SLLspStatus#" .. status .. "%*"
        vim.cmd("redrawstatus")

        lsp_status_timer = vim.defer_fn(function()
            current_lsp_status = ""
            lsp_status_timer = nil
            vim.cmd("redrawstatus")
        end, 500)
    end
end

local function get_git_branch()
    local branch = vim.b.gitsigns_head
    if branch and branch ~= "" then
        return " %#SLBranch#⎇ " .. branch .. "%*"
    end
    return ""
end

local function get_file_segment()
    if current_file_path == "" then return "" end
    local dot = vim.bo.modified and "%#SLModified#●%*" or "%#SLUnmodified#●%*"
    return "  " .. dot .. " %#SLFilename#" .. current_file_path .. "%*"
end

local function get_filesize()
    local size = vim.fn.getfsize(vim.fn.expand("%:p"))
    if size <= 0 then return "" end
    local fmt
    if size < 1024 then
        fmt = size .. "b"
    elseif size < 1048576 then
        fmt = string.format("%.2fk", size / 1024)
    else
        fmt = string.format("%.2fm", size / 1048576)
    end
    return "%#SLFileSize#" .. fmt .. "%*"
end

-- Official language brand colors
local ft_colors = {
    -- Web
    html            = "#E34F26",
    css             = "#1572B6",
    javascript      = "#F7DF1E",
    javascriptreact = "#61DAFB",
    typescript      = "#3178C6",
    typescriptreact = "#61DAFB",
    vue             = "#42B883",
    svelte          = "#FF3E00",
    -- Backend
    php             = "#8892BF",
    python          = "#3776AB",
    ruby            = "#CC342D",
    go              = "#00ADD8",
    rust            = "#CE4A09",
    java            = "#ED8B00",
    kotlin          = "#7F52FF",
    swift           = "#F05138",
    elixir          = "#6E4A7E",
    -- Systems
    c               = "#A8B9CC",
    cpp             = "#00599C",
    -- Scripting
    lua             = "#2C2D72",
    sh              = "#4EAA25",
    bash            = "#4EAA25",
    fish            = "#4EAA25",
    -- Data / Config
    json            = "#CBCB41",
    yaml            = "#CB171E",
    toml            = "#9C4121",
    -- Other
    sql             = "#E38D00",
    dockerfile      = "#2496ED",
    terraform       = "#844FBA",
    haskell         = "#5D4F85",
    scala           = "#DC322F",
    dart            = "#0175C2",
    markdown        = "#519ABA",
}

local ft_hl_cache = {}

local function get_ft_hl(ft)
    if ft_hl_cache[ft] then return ft_hl_cache[ft] end

    local hex = ft_colors[ft]
    if not hex then
        ft_hl_cache[ft] = "SLFiletype"
        return "SLFiletype"
    end

    local r = tonumber(hex:sub(2, 3), 16)
    local g = tonumber(hex:sub(4, 5), 16)
    local b = tonumber(hex:sub(6, 7), 16)
    local bg_int = r * 65536 + g * 256 + b

    -- Perceived luminance: pick dark fg for light bg, light fg for dark bg
    local luminance = 0.299 * r + 0.587 * g + 0.114 * b
    local fg_int = luminance > 128
        and (vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg or 0x1a1a1a)
        or  (vim.api.nvim_get_hl(0, { name = "Normal" }).fg    or 0xe0e0e0)

    local hl_name = "SLFt_" .. ft
    vim.api.nvim_set_hl(0, hl_name, { fg = fg_int, bg = bg_int, bold = true })
    ft_hl_cache[ft] = hl_name
    return hl_name
end

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function() ft_hl_cache = {} end,
})

local version_cache = {}

local version_cmds = {
    php             = { cmd = "php --version",    pat = "PHP (%d+%.%d+)" },
    go              = { cmd = "go version",        pat = "go(%d+%.%d+)" },
    javascript      = { cmd = "node --version",    pat = "v(%d+%.%d+)" },
    typescript      = { cmd = "node --version",    pat = "v(%d+%.%d+)" },
    javascriptreact = { cmd = "node --version",    pat = "v(%d+%.%d+)" },
    typescriptreact = { cmd = "node --version",    pat = "v(%d+%.%d+)" },
    python          = { cmd = "python3 --version", pat = "Python (%d+%.%d+)" },
    ruby            = { cmd = "ruby --version",    pat = "ruby (%d+%.%d+)" },
    rust            = { cmd = "rustc --version",   pat = "rustc (%d+%.%d+)" },
    lua             = { cmd = "lua -v 2>&1",        pat = "Lua (%d+%.%d+)" },
    elixir          = { cmd = "elixir --version",  pat = "Elixir (%d+%.%d+)" },
    kotlin          = { cmd = "kotlin -version 2>&1", pat = "(%d+%.%d+)" },
    swift           = { cmd = "swift --version 2>&1", pat = "Swift version (%d+%.%d+)" },
}

local function get_runtime_version(ft)
    if version_cache[ft] ~= nil then
        return version_cache[ft]
    end
    local spec = version_cmds[ft]
    if not spec then
        version_cache[ft] = ""
        return ""
    end
    local out = vim.fn.system(spec.cmd):match(spec.pat) or ""
    version_cache[ft] = out
    return out
end

local function get_filetype()
    local ft = vim.bo.filetype
    if ft == "" then return "" end
    local ver = get_runtime_version(ft)
    local label = ver ~= "" and (ft .. " " .. ver) or ft
    local hl = get_ft_hl(ft)
    return "  %#" .. hl .. "# " .. label .. " %*"
end

local function get_diagnostics()
    local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local warns  = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    if errors == 0 and warns == 0 then
        return "  %#SLDiagOk#○ 0%*"
    end
    local parts = {}
    if errors > 0 then table.insert(parts, "%#SLDiagError#E:" .. errors .. "%*") end
    if warns  > 0 then table.insert(parts, "%#SLDiagWarn#W:" .. warns  .. "%*") end
    return "  " .. table.concat(parts, " ")
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "FocusGained" }, {
    callback = function()
        set_filepath()
        set_mode()
    end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    callback = set_mode,
})

vim.api.nvim_create_autocmd("LspProgress", {
    callback = set_lsp_status,
})

function _G.status_line()
    local left  = current_mode .. get_git_branch() .. get_file_segment()
    local right = get_filesize()
        .. get_filetype()
        .. get_diagnostics()
        .. "  %#SLPosition# %l: %c %*"
        .. " "

    return left .. "%=" .. current_lsp_status .. "%=" .. right
end

vim.opt.laststatus = 3
vim.o.statusline = "%!v:lua.status_line()"
