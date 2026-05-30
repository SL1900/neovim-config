return {
    "s1n7ax/nvim-window-picker",
    config = function ()
        require("window-picker").setup({
            hint = "floating-big-letter",
            picker_config = {
                floating_big_letter = {
                    font = "ansi-shadow"
                }
            }
        })
    end
}
