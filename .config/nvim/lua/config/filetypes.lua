vim.filetype.add({
    pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
vim.filetype.add({
    extension = {
        sig = "c",
        slint = "slint",
    },
})
