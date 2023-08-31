local link = s({
  trig = "link",
  name = "Link",
  dscr = "Web link"
}, {
  t({ "`" }),
  i(1, "Title"),
  t(" <"),
  i(2, "link"),
  t(">`_"),
  i(0)
})
