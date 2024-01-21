return {
    "ldelossa/nvim-dap-projects",

    priority = 800,

    config = function()
        local projects = require("nvim-dap-projects")

        projects.search_project_config()
    end,
}
