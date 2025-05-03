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
  local n, m = dims:match '(%d+)p(%d+)'
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
        \begin{{enumerate}}[{}]
          \item {}
        \end{{enumerate}}
      ]],
      {
        i(1, '1.'),
        i(2),
      }
    )
  ),

  s(
    { trig = ':ben', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
        \begin{{enumerate*}}[{}]
          \item {}
        \end{{enumerate*}}
      ]],
      {
        i(1, '1.'),
        i(2),
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
      ]],
      {
        i(1),
        i(2),
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
      ]],
      {
        i(1),
        i(2),
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
      ]],
      {
        i(1),
      }
    )
  ),

  s(
    { trig = ';mat(%d+p%d+)', regTrig = true, name = 'matriz' },
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

  s(
    { trig = ';sel', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \begin{{cases}}
        {}
      \end{{cases}}
      ]],
      {
        i(1),
      }
    )
  ),

  -- NOTE: MATH

  s(
    { trig = ';int', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
    \int_{{{}}}^{{{}}} {} \,d{}
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s(
    { trig = ';iint', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \iint_{{{}}} {} \,d{} \,d{}
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s(
    { trig = ';iiint', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \iiint_{{{}}} {} \,d{} \,d{} \,d{}
      ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
      }
    )
  ),

  s(
    { trig = ';dv', snippetType = 'autosnippet', wordTrig = false },
    fmt([[\dv[{}]{{{}}}{{{}}}]], {
      i(1),
      i(2),
      i(3),
    })
  ),

  s(
    { trig = ';dp', snippetType = 'autosnippet', wordTrig = false },
    fmt([[\pdv[{}]{{{}}}{{{}}}]], {
      i(1),
      i(2),
      i(3),
    })
  ),

  s(
    { trig = ';sum', snippetType = 'autosnippet', wordTrig = false },
    fmt('\\sum_{{{}}}^{{{}}} {}', {
      i(1),
      i(2),
      i(0),
    })
  ),

  s({ trig = ';sin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\sin^{{{}}}', { i(1) })),

  s({ trig = ';cos', snippetType = 'autosnippet', wordTrig = false }, fmt('\\cos^{{{}}}', { i(1) })),

  s({ trig = ';tg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\tg^{{{}}}', { i(1) })),

  s({ trig = ':sin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\csc^{{{}}}', { i(1) })),

  s({ trig = ':cos', snippetType = 'autosnippet', wordTrig = false }, fmt('\\sec^{{{}}}', { i(1) })),

  s({ trig = ':tg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\cot^{{{}}}', { i(1) })),

  s({ trig = ';fra', snippetType = 'autosnippet', wordTrig = false }, fmt('\\frac{{{}}}{{{}}}', { i(1), i(2) })),

  s({ trig = ';eql', snippetType = 'autosnippet', wordTrig = false }, fmt('$ {} $', { i(1) })),

  s({ trig = ';neq', snippetType = 'autosnippet', wordTrig = false }, t '\\neq'),

  s({ trig = ';aprox', snippetType = 'autosnippet', wordTrig = false }, t '\\approx'),

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

  s(
    { trig = ';log', snippetType = 'autosnippet' },
    fmt('\\log_{{{}}}{{{}}}', {
      i(1),
      i(2),
    })
  ),

  s(
    { trig = ';ln', snippetType = 'autosnippet' },
    fmt('\\ln{{{}}}', {
      i(1),
    })
  ),

  s(
    { trig = ';rai', snippetType = 'autosnippet' },
    fmt('\\sqrt[{}]{{{}}}', {
      i(1),
      i(2),
    })
  ),

  s(
    { trig = ';lim', snippetType = 'autosnippet' },
    fmt('\\lim_{{{} \\to {}}}{{{}}}', {
      i(1, 'x'),
      c(2, { fmt('{}', { i(1) }), t '\\infty', t '-\\infty' }),
      i(3, ''),
    })
  ),

  s(
    { trig = ';ilim', snippetType = 'autosnippet' },
    fmt('\\displaystyle \\lim_{{{} \\to {}}}{{{}}}', {
      i(1, 'x'),
      c(2, { fmt('{}', { i(1) }), t '\\infty', t '-\\infty' }),
      i(3, ''),
    })
  ),

  -- NOTE: SECTIONS

  s({ trig = ';sec', snippetType = 'autosnippet', wordTrig = false }, fmt('\\section{{{}}}', { i(1) })),

  s({ trig = ';ssc', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsection{{{}}}', { i(1) })),

  s({ trig = ';sss', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsubsection{{{}}}', { i(1) })),

  s({ trig = ';spar', snippetType = 'autosnippet', wordTrig = false }, fmt('\\paragraph{{{}}}\\mbox{{}}', { i(1) })),

  s({ trig = ':sec', snippetType = 'autosnippet', wordTrig = false }, fmt('\\section*{{{}}}', { i(1) })),

  s({ trig = ':ssc', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsection*{{{}}}', { i(1) })),

  s({ trig = ':sss', snippetType = 'autosnippet', wordTrig = false }, fmt('\\subsubsection*{{{}}}', { i(1) })),

  s({ trig = ':spar', snippetType = 'autosnippet', wordTrig = false }, fmt('\\paragraph*{{{}}}\\mbox{{}}', { i(1) })),

  -- NOTE:  LOGIC OPERATORS

  s({ trig = ';fall', snippetType = 'autosnippet', wordTrig = false }, { t ' \\forall ' }),

  s({ trig = ';exis', snippetType = 'autosnippet', wordTrig = false }, { t ' \\exists ' }),

  s({ trig = ';imp', snippetType = 'autosnippet', wordTrig = false }, { t ' \\implies ' }),

  s({ trig = ';iff', snippetType = 'autosnippet', wordTrig = false }, { t ' \\iff ' }),

  s({ trig = ';sub', snippetType = 'autosnippet', wordTrig = false }, { t ' \\subset ' }),

  s({ trig = ';sup', snippetType = 'autosnippet', wordTrig = false }, { t ' \\supset ' }),

  s({ trig = ';esub', snippetType = 'autosnippet', wordTrig = false }, { t ' \\subseteq ' }),

  s({ trig = ';esup', snippetType = 'autosnippet', wordTrig = false }, { t ' \\supseteq ' }),

  s({ trig = ';cap', snippetType = 'autosnippet', wordTrig = false }, { t ' \\cap ' }),

  s({ trig = ';cup', snippetType = 'autosnippet', wordTrig = false }, { t ' \\cup ' }),

  s({ trig = ':cup', snippetType = 'autosnippet', wordTrig = false }, fmt(' \\bigcup_{{{}}}^{{{}}} ', { i(1), i(2) })),

  s({ trig = ';per', snippetType = 'autosnippet', wordTrig = false }, { t ' \\in ' }),

  s({ trig = ';nper', snippetType = 'autosnippet', wordTrig = false }, { t ' \\notin ' }),

  s({ trig = ';vacio', snippetType = 'autosnippet', wordTrig = false }, { t ' \\varnothing ' }),

  s({ trig = ';equiv', snippetType = 'autosnippet', wordTrig = false }, { t ' \\equiv ' }),

  s({ trig = ';and', snippetType = 'autosnippet', wordTrig = false }, { t ' \\land ' }),

  s({ trig = ';or', snippetType = 'autosnippet', wordTrig = false }, { t ' \\lor ' }),

  s({ trig = ';xor', snippetType = 'autosnippet', wordTrig = false }, { t ' \\oplus ' }),

  s({ trig = ';to', snippetType = 'autosnippet', wordTrig = false }, { t ' \\to ' }),

  s({ trig = ';mid', snippetType = 'autosnippet', wordTrig = false }, { t ' \\mid ' }),

  -- NOTE: MISCELLANEOUS

  s({ trig = ';alfa', snippetType = 'autosnippet', wordTrig = false }, { t '\\alpha' }),
  s({ trig = ';beta', snippetType = 'autosnippet', wordTrig = false }, { t '\\beta' }),
  s({ trig = ';gama', snippetType = 'autosnippet', wordTrig = false }, { t '\\gamma' }),
  s({ trig = ';delta', snippetType = 'autosnippet', wordTrig = false }, { t '\\delta' }),
  s({ trig = ';epsi', snippetType = 'autosnippet', wordTrig = false }, { t '\\varepsilon' }),
  s({ trig = ';theta', snippetType = 'autosnippet', wordTrig = false }, { t '\\theta' }),
  s({ trig = ';kappa', snippetType = 'autosnippet', wordTrig = false }, { t '\\kappa' }),
  s({ trig = ';lamda', snippetType = 'autosnippet', wordTrig = false }, { t '\\lambda' }),
  s({ trig = ';mu', snippetType = 'autosnippet', wordTrig = false }, { t '\\mu' }),
  s({ trig = ';pi', snippetType = 'autosnippet', wordTrig = false }, { t '\\pi' }),
  s({ trig = ';rho', snippetType = 'autosnippet', wordTrig = false }, { t '\\rho' }),
  s({ trig = ';sigma', snippetType = 'autosnippet', wordTrig = false }, { t '\\sigma' }),
  s({ trig = ';tau', snippetType = 'autosnippet', wordTrig = false }, { t '\\tau' }),
  s({ trig = ';fi', snippetType = 'autosnippet', wordTrig = false }, { t '\\varphi' }),
  s({ trig = ';psi', snippetType = 'autosnippet', wordTrig = false }, { t '\\psi' }),
  s({ trig = ';omega', snippetType = 'autosnippet', wordTrig = false }, { t '\\omega' }),

  s({ trig = ':gama', snippetType = 'autosnippet', wordTrig = false }, { t '\\Gamma' }),
  s({ trig = ':delta', snippetType = 'autosnippet', wordTrig = false }, { t '\\Delta' }),
  s({ trig = ':theta', snippetType = 'autosnippet', wordTrig = false }, { t '\\Theta' }),
  s({ trig = ':lamda', snippetType = 'autosnippet', wordTrig = false }, { t '\\Lambda' }),
  s({ trig = ':pi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Pi' }),
  s({ trig = ':sigma', snippetType = 'autosnippet', wordTrig = false }, { t '\\Sigma' }),
  s({ trig = ':fi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Phi' }),
  s({ trig = ':psi', snippetType = 'autosnippet', wordTrig = false }, { t '\\Psi' }),
  s({ trig = ':omega', snippetType = 'autosnippet', wordTrig = false }, { t '\\Omega' }),

  s({ trig = ';inft', snippetType = 'autosnippet', wordTrig = false }, { t '\\infty ' }),

  s({ trig = ';dot', snippetType = 'autosnippet', wordTrig = false }, { t '\\dots ' }),

  s({ trig = ';por', snippetType = 'autosnippet', wordTrig = false }, { t '\\times ' }),

  s({ trig = ';prima', snippetType = 'autosnippet', wordTrig = false }, t '^{\\prime}'),

  s({ trig = ';txt', snippetType = 'autosnippet', wordTrig = false }, fmt('\\text{{{}}}', { i(1) })),

  s({ trig = ';esp', snippetType = 'autosnippet', wordTrig = false }, t '\\quad '),

  s({ trig = ':esp', snippetType = 'autosnippet', wordTrig = false }, t '\\qquad '),

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

  s({ trig = ';vmod', snippetType = 'autosnippet', wordTrig = false }, fmt('\\lVert{}\\rVert', { i(1) })),

  s({ trig = ';mod', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left|{}\\right|', { i(1) })),

  s({ trig = ';sq', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left[{}\\right]', { i(1) })),

  s({ trig = ';pa', snippetType = 'autosnippet', wordTrig = false }, fmt('\\left({}\\right)', { i(1) })),

  s({ trig = ';ll', snippetType = 'autosnippet', wordTrig = false }, { t '\\left\\{', i(1), t '\\right\\}' }),

  s({ trig = ';ere', snippetType = 'autosnippet', wordTrig = false }, fmt('\\mathbb{{R}}^{{{}}}', { i(1) })),

  s({ trig = ';vec', snippetType = 'autosnippet', wordTrig = false }, fmt('\\vec{{{}}}', { i(1) })),

  s({ trig = ';tbf', snippetType = 'autosnippet', wordTrig = false }, fmt('\\textbf{{{}}}', { i(1) })),

  s({ trig = ';tit', snippetType = 'autosnippet', wordTrig = false }, fmt('\\textit{{{}}}', { i(1) })),

  s({ trig = ';seg', snippetType = 'autosnippet', wordTrig = false }, fmt('\\overline{{{}}}', { i(1) })),

  s({ trig = ';sb', snippetType = 'autosnippet', wordTrig = false }, fmt('_{{{}}}', { i(1) })),

  s({ trig = ';ala', snippetType = 'autosnippet', wordTrig = false }, fmt('^{{{}}}', { i(1) })),

  s({ trig = ';ulin', snippetType = 'autosnippet', wordTrig = false }, fmt('\\underline{{{}}}', { i(1) })),

  s({ trig = ';oll', snippetType = 'autosnippet', wordTrig = false }, fmt('\\overbrace{{{}}}^{{{}}}', { i(1), i(2) })),

  s({ trig = ';ull', snippetType = 'autosnippet', wordTrig = false }, fmt('\\underbrace{{{}}}_{{{}}}', { i(1), i(2) })),

  s({ trig = ';ref', snippetType = 'autosnippet', wordTrig = false }, fmt('\\ref{{{}}}', { i(1) })),

  s({ trig = ';aql', snippetType = 'autosnippet', wordTrig = false }, { t ' &= ' }),

  s(
    { trig = ';tbox', snippetType = 'autosnippet', wordTrig = false },
    fmt(
      [[
      \fbox{{\parbox{{{}\linewidth}}{{
      \textbf{{{}}}
      
      {}
      }}}}\vspace{{0.2cm}}
      ]],
      {
        i(1, '0.9'),
        i(2, 'Título'),
        i(3),
      }
    )
  ),

  s({ trig = ';ebox', snippetType = 'autosnippet', wordTrig = false }, fmt([[ \centerline{{\boxed{{{}}}}} ]], { i(1) })),

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
        \usepackage{{physics}}
        \usepackage{{enumerate}}
        \usepackage[colorlinks=true, citecolor=blue]{{hyperref}}

        % Para graficar
        \usepackage{{pgfplots}}
        \usepackage{{tikz, color}}
        \usepackage{{tikz-3dplot}}
        \pgfplotsset{{width=15cm, compat=1.12}}

        % Encabezados
        \usepackage{{fancyhdr}}
        \pagestyle{{fancy}}
        \fancyhf{{}}
        \fancyfoot[C]{{\thepage}}
        \fancyhead[L]{{
          \includegraphics[height=1.2cm]{{~/imagenes/logo_utn.png}}
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
            \includegraphics[width=\linewidth]{{~/imagenes/logo_utn_frc.jpg}}\\

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
}
