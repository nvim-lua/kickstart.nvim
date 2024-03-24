use {
  "ms-jpq/coq_nvim",
  branch = "coq",
  event = "InsertEnter",
  opt = true,
  run = ":COQdeps",
  config = function()
    require("config.coq").setup()
  end,
  requires = {
    { "ms-jpq/coq.artifacts", branch = "artifacts" },
    { "ms-jpq/coq.thirdparty", branch = "3p", module = "coq_3p" },
  },
  disable = false,
}
