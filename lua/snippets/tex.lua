-- Estos son los snippets que se van a cargar para todos los documentos de latex

vim.keymap.set({ 'i', 's' }, '<C-l>', function()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(1)
  end
end)

vim.keymap.set({ 'i', 's' }, '<C-h>', function()
  if require('luasnip').choice_active() then
    require('luasnip').change_choice(-1)
  end
end)

-- Generador dinámico de matrices
local function matrix_generator(_, snip)
  local dims = snip.captures[1] -- Extraído del regex (por ejemplo, "3x3")
  local n, m = dims:match '(%d+)x(%d+)'
  n = tonumber(n)
  m = tonumber(m)
  local nodes = {}

  for row = 1, n do
    for col = 1, m do
      table.insert(nodes, i((row - 1) * m + col, ''))
      if col < m then
        table.insert(nodes, t ' & ')
      end
    end
    if row < n then
      table.insert(nodes, t { ' \\\\', '' })
    end
  end

  return sn(nil, nodes)
end

return {
  -- NOTE: AUTOSNIPPETS

  -- NOTE: ENVIRONMENTS

  s(
    { trig = ';ben', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{enumerate}}{}
          \item {}
        \end{{enumerate}}
        {}
      ]],
      {
        c(1, {
          t '',
          fmt('[A{}]', { i(1, '.') }),
          fmt('[a{}]', { i(1, '.') }),
          fmt('[i{}]', { i(1, '.') }),
          fmt('[{}]', { i(1) }),
        }),
        i(2),
        i(0),
      }
    )
  ),

  s(
    { trig = ':ben', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{enumerate*}}{}
          \item {}
        \end{{enumerate*}}
        {}
      ]],
      {
        c(1, {
          t '',
          fmt('[A{}]', { i(1, '.') }),
          fmt('[a{}]', { i(1, '.') }),
          fmt('[i{}]', { i(1, '.') }),
          fmt('[{}]', { i(1) }),
        }),
        i(2),
        i(0),
      }
    )
  ),

  s(
    { trig = ';bal', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{align}}
          {} &= {}
        \end{{align}}
        {}
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    { trig = ':bal', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{align*}}
          {} &= {}
        \end{{align*}}
        {}
      ]],
      {
        i(1),
        i(2),
        i(0),
      }
    )
  ),

  s(
    { trig = ';bit', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \begin{{itemize}}
        \item {}
      \end{{itemize}}
      {}
      ]],
      {
        i(1),
        i(0),
      }
    )
  ),

  s(
    { trig = ';mat(%d+x%d+)', regTrig = true, name = 'Matrix' },
    fmt(
      [[
      \begin{{{}}}
      {}
      \end{{{}}}
      ]],
      {
        c(1, {
          t 'bmatrix',
          t 'pmatrix',
          t 'Bmatrix',
          t 'vmatrix',
          t 'Vmatrix',
          t 'matrix',
        }),
        d(2, matrix_generator, {}),
        rep(1),
      }
    )
  ),

  -- NOTE: MATH

  s(
    { trig = ';int', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \int{} {} \,d{}
    ]],
      {
        c(1, {
          t '',
          sn(nil, fmt('_{{{}}}^{{{}}}', { i(1), i(2) })),
        }),
        i(2),
        i(0),
      }
    )
  ),

  s(
    { trig = ';iint', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \iint{} {} \,d{} \,d{}
      ]],
      {
        c(1, {
          t '',
          sn(nil, fmt([[ _{{{}}} ]], { i(1) })),
        }),
        i(2),
        i(3),
        i(0),
      }
    )
  ),

  s(
    { trig = ';iiint', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \iiint{} {} \,d{} \,d{} \,d{}
      ]],
      {
        c(1, {
          t '',
          sn(nil, fmt([[_{{{}}}]], { i(1) })),
        }),
        i(2),
        i(3),
        i(4),
        i(0),
      }
    )
  ),

  s(
    { trig = ';dv', snippetType = 'autosnippet', wordTrig = false },
    fmt([[\dv{}]], {
      c(1, {
        sn(nil, fmt([[{{{}}}]], { i(1) })),
        sn(nil, fmt([[{{{}}}{{{}}}]], { i(1), i(2) })),
        sn(nil, fmt([[[{}]{{{}}}{{{}}}]], { i(1), i(2), i(3) })),
      }),
    })
  ),

  s(
    { trig = ';dp', snippetType = 'autosnippet', wordTrig = false },
    fmt([[\pdv{}{}]], {
      c(1, { fmt('{{{}}}', { i(1) }), fmt('[{}]', { i(1) }) }),
      c(2, { fmt('{{{}}}', { i(1) }), fmt('{{{}}}{{{}}}', { i(1), i(2) }), fmt('{{{}}}{{{}}}{{{}}}', { i(1), i(2), i(3) }) }),
    })
  ),

  s(
    { trig = ';sum', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\sum{} {}', {
      c(1, { t '', fmt('_{{{}}}^{{{}}}', { i(1), i(2) }) }),
      i(0),
    })
  ),

  s({ trig = ';sin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\sin{} {}', { i(1), i(2) })),

  s({ trig = ';cos', snippetType = 'autosnippet', wordTrig = false }, fmt('\\cos{} {}', { i(1), i(2) })),

  s({ trig = ';tan', snippetType = 'autosnippet', wordTrig = false }, fmt('\\tan{} {}', { i(1), i(2) })),

  s({ trig = ';sec', snippetType = 'autosnippet', wordTrig = false }, fmt('\\sec{} {}', { i(1), i(2) })),

  s({ trig = ';csc', snippetType = 'autosnippet', wordTrig = false }, fmt('\\csc{} {}', { i(1), i(2) })),

  s({ trig = ';cot', snippetType = 'autosnippet', wordTrig = false }, fmt('\\cot{} {}', { i(1), i(2) })),

  s({ trig = ';fr', snippetType = 'autosnippet', wordTrig = false }, fmt('\\frac{{{}}}{{{}}}', { i(1), i(2) })),

  s({ trig = ';eql', snippetType = 'autosnippet', wordTrig = false }, fmt('$ {} $', { i(1) })),

  s(
    { trig = ';eqb', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \[
      {}
      \]
      ]],
      { i(1) }
    )
  ),

  -- NOTE: SECTIONS

  -- NOTE: MISCELLANEOUS

  s({ trig = ';it', snippetType = 'autosnippet', wordTrig = false }, { t { '', '', '\\item ' } }),

  s(
    { trig = ';atm', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \\
      {} &= {}
      ]],
      { i(1), i(0) }
    )
  ),

  -- NORMAL SNIPPETS
  s(
    'utninf',
    fmt(
      [[
        \documentclass[12pt]{{article}}
        \usepackage[spanish]{{babel}}
        \usepackage[utf8]{{inputenc}}
        \usepackage{{csquotes}}
        
        % Interlineado 1.5
        \usepackage{{setspace}}
        \onehalfspacing

        % Fuente Times New Roman
        \usepackage{{mathptmx}}
        
        % Acomodar margenes del documento
        \usepackage[a4paper, margin=2cm, top=3cm, headheight=50pt]{{geometry}}

        % Paquetes comunes
        \usepackage{{graphicx, float}}
        \usepackage{{amsfonts, amssymb, amsmath}}
        \usepackage{{enumerate}}
        \usepackage[colorlinks=true, citecolor=blue]{{hyperref}}

        % Encabezados
        \usepackage{{fancyhdr}}
        \pagestyle{{fancy}}
        \fancyhf{{}}
        \fancyfoot[C]{{\thepage}}
        \fancyhead[L]{{
          \includegraphics[height=1.2cm]{{C:/Users/ricar/OneDrive/Escritorio/Ingeniería en Sistemas/logo_utn.png}}
          \shortstack[l]{{
            {{\footnotesize Universidad Tecnológica Nacional}} \\
            {{\footnotesize Facultad Regional Córdoba}} \\
            {{\footnotesize Extensión Áulica Bariloche}}
          }}
        }}
        \fancyhead[C]{{
          \shortstack[c]{{
            {{\footnotesize {}}} \\
            {{\footnotesize {}}} \\
            {{\footnotesize }}
          }}
        }}
        \fancyhead[R]{{
          \shortstack[r]{{
            {{\footnotesize Profesor: {}}} \\
            {{\footnotesize Alumno: Ricardo Nicolás Freccero}} \\
            {{\footnotesize Fecha: {}}}
          }}
        }}

        % Para bibliografía
        %\usepackage[backend=biber, style=apa]{{biblatex}}
        %\addbibresource{{bibliografia.bib}}

        \begin{{document}}
        \newgeometry{{margin=2cm, top=1.5cm}}
          \begin{{titlepage}}
            \centering
            \includegraphics[width=\linewidth]{{C:/Users/ricar/OneDrive/Escritorio/Ingeniería en Sistemas/logo_utn_frc.jpg}}\\

            \textsc{{
              \LARGE Universidad Tecnológica Nacional\\
              \Large Facultad Regional Córdoba - Extensión Áulica Bariloche\\
              \large Ingeniería en Sistemas de Información\\
              Año lectivo {}\\[0.5cm]
            }}

            \rule{{\linewidth}}{{1.0mm}}\\[0.4cm]
            \Huge
            \textbf{{{}}}\\
            {}\\[0.2cm]
            \LARGE
            {}
            \rule{{\linewidth}}{{1.0mm}}\\
            \large
            \begin{{flushleft}}
              Profesor: {}

              Ayudante: {}

              Fecha: {}
            \end{{flushleft}}

            \vfill
            \begin{{flushright}}
              Alumno: Ricardo Nicolás Freccero  

              Número de legajo: 415753
            \end{{flushright}}
          \end{{titlepage}}
          
          \restoregeometry
          \tableofcontents
          \newpage

          \section{{Enunciado}}
          {}

          \section{{Introducción}}


          \section{{Desarrollo}}


          \section{{Conclusión}}

          %\addcontentsline{{toc}}{{section}}{{Referencias}}
          %\printbibliography
          
        \end{{document}}
      ]],
      {
        rep(2),
        rep(3),
        rep(5),
        rep(7),
        i(1, 'Año'),
        i(2, 'Materia'),
        i(3, 'Trabajo Práctico N°'),
        i(4, 'Título'),
        i(5, 'Nombre Profesor'),
        i(6, 'Nombre Ayudante'),
        i(7, 'Fecha'),
        i(0),
      }
    )
  ),
  s(
    'enumerate',
    fmt(
      [[
        \begin{{enumerate}}{}
          \item {}
        \end{{enumerate}}
      ]],
      {
        c(1, {
          t '',
          fmt('[A{}]', { i(1, '.') }),
          fmt('[a{}]', { i(1, '.') }),
          fmt('[i{}]', { i(1, '.') }),
        }),
        i(0),
      }
    )
  ),
  s('item', { t { '', '', '\\item ' } }),
  s(
    'begin',
    fmt(
      [[
        \begin{{{}}}{}
          {}
        \end{{{}}}
        {}
      ]],
      {
        i(1, 'environment'),
        c(2, {
          t '',
          fmt('[{}]', { i(1, 'opcional') }),
        }),
        i(3),
        rep(1),
        i(0),
      }
    )
  ),
  s(
    'figure',
    fmt(
      [[
        \begin{{figure}}{}
          \centering
          \includegraphics[width={}\linewidth]{{{}}}
          \caption{{{}}}
          \label{{fig:{}}}
        \end{{figure}}
        {}
      ]],
      {
        c(1, {
          fmt('[{}]', { i(1, 'H') }),
          t '',
        }),
        i(2),
        i(3),
        i(4),
        i(5),
        i(0),
      }
    )
  ),
  s(
    'align',
    fmt(
      [[
        \begin{{align}}{}
          {} &= {}
        \end{{align}}
        {}
      ]],
      {
        c(1, {
          t '',
          fmt('[{}]', { i(1, 'H') }),
        }),
        i(2),
        i(3),
        i(0),
      }
    )
  ),
}
