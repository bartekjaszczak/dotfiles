-- LaTeX editing with preview
return {
    "lervag/vimtex",

    config = function()
        vim.g.vimtex_view_method = "zathura"
        -- vim.g.vimtex_view_general_viewer = "okular"
        -- vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"

        vim.g.maplocalleader = " "
        local vimscript = [[
        augroup vimtex
          autocmd!
          autocmd User VimtexEventView call b:vimtex.viewer.xdo_focus_vim()
        augroup END
        ]]

        vim.cmd(vimscript)
    end,
}
