return {
    -- "lionyxml/gitlineage.nvim",
    "stip/gitlineage.nvim",
    depenmdencies = {
        "sindrets/diffview.nvim",
    },
    config = function ()
        require("gitlineage").setup()
    end
}
