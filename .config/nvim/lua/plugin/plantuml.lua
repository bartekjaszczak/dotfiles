return {
    "https://gitlab.com/itaranto/plantuml.nvim",
    version = "*",

    config = function()
        require("plantuml").setup({
            -- -- Setup for imv
            -- renderer = {
            --     type = "imv",
            --     options = {
            --         dark_mode = true,
            --     },
            -- },
            -- render_on_write = true,

            -- Setup for image (feh)
            renderer = {
                type = "image",
                options = {
                    prog = "feh",
                    -- dark_mode = true,
                },
            },
            render_on_write = true,

            -- -- Setup for text
            -- renderer = {
            --     type = "text",
            --     options = {
            --         split_cmd = "vsplit",
            --     }
            -- }
        })
    end,
}
