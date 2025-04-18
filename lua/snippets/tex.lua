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

return {
  -- AUTOSNIPPETS
  s(
    { trig = ';ait', snippetType = 'autosnippet' },
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
      ]],
      {
        i(1, 'environment'),
        c(2, {
          t '',
          fmt('[{}]', { i(1, 'opcional') }),
        }),
        i(0),
        rep(1),
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
