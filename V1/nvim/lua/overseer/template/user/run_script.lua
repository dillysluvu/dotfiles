return {
    name = "run C++ script",
    builder = function()
        local file = vim.fn.expand("%:p")
        local output_file = vim.fn.expand("%:p:r") .. ".out"

        return {
            cmd = { "sh", "-c", "g++ " .. file .. " -o " .. output_file .. " && ./" .. output_file },
            components = {
                { "on_output_quickfix", set_diagnostics = true },
                "on_result_diagnostics",
                "default",
            },
        }
    end,
    condition = {
        filetype = { "cpp" },
    },
}
