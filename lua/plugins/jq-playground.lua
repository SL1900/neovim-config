return {
    "yochem/jq-playground.nvim",
    opts = {
        -- cmd = { "jq", "-n" },
    },
    config = function (_, opts)
        require("jq-playground").setup(opts)
    end
}
