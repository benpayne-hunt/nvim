local M = {}

function M.remove_empty_strings(data)
    local result = {}

    for _, value in ipairs(data) do
        if value ~= "" then
            table.insert(result, value)
        end
    end

    return result
end

function M.merge(...)
    local result = {}

    for _, t in ipairs({ ... }) do
        for _, v in ipairs(t) do
            table.insert(result, v)
        end
    end

    return result
end

return M
