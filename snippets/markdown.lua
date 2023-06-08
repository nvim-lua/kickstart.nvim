require("luasnip.session.snippet_collection").clear_snippets "text"

local ls = require "luasnip"

local s = ls.s
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

ls.add_snippets("markdown", {
  s(
    "ytv",
    fmta(
      [[

<div class='vimeo-container'>
  <iframe src="//www.youtube.com/embed/[youtubecode]"
    width="640"
    height="360"
    frameborder="0"
    allow="autoplay;
    fullscreen;
    picture-in-picture"
    allowfullscreen>
  </iframe>
</div>

]],
      {
        youtubecode = i(1),
      },
      { delimiters = "[]" }
    )
  ),
  s(
    "trl",
    fmta(
      [[

<div class='transparent-table'>

|||
|------|----|
|<img src={require('./images/%courseimage+.png').default} class="image" alt="course logo" style={{width: '16rem', 'background-color': 'transparent'}}/>|ClickHouse provides free training on %coursetopic+ and many other topics.  The [%coursetopic2+ training course](https://learn.clickhouse.com/visitor_catalog_class/show/%coursecode+/?utm_source=clickhouse&utm_medium=docs) is a good place to start.|

</div>

]],
      {
        courseimage = i(1),
        coursetopic = i(2),
        coursetopic2 = i(3),
        coursecode = i(4),
      },
      { delimiters = "%+" }
    )
  ),
})

