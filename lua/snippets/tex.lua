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
  s(
    'utninf',
    fmt(
      [[
        \documentclass[12pt a4paper]{{article}}
        \usepackage[spanish]{{babel}}
        \usepackage[utf8]{{inputenc}}
        
        % Interlineado 1.5
        \usepackage{{setspace}}
        \onehalfspacing

        % Fuente Times New Roman
        \usepackage{{mathptmx}}
        
        % Acomodar margenes del documento
        \usepackage[margin=2cm]{{geometry}}

        % Paquetes comunes
        \usepackage{{graphicx, float}}
        \usepackage{{amsfonts, amssymb, amsmath}}
        \usepackage{{enumerate}}
        \usepackage[colorlinks=true, citecolor=blue]{{hyperref}}

        % Para bibliografía
        %\usepackage[backend=biber, style=apa]{{biblatex}}
        %\addbibresource{{bibliografia.bib}}

        \begin{{document}}
          \begin{{titlepage}}
            \centering
            \includegraphics[width=\linewidth]{{C:/Users/ricar/OneDrive/Escritorio/Ingerniería en Sistemas/logo_utn.jpg}}\\[1cm]

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
            \Large
            \begin{{flushleft}}
              Profesor: {}

              Ayudante: {}
            \end{{flushleft}}

            \vfill
            \begin{{flushright}}
              Alumno: Ricardo Nicolás Freccero  

              Número de legajo: 415753
            \end{{flushright}}
          \end{{titlepage}}
          
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
        i(1),
        i(2, 'Materia'),
        i(3, 'Número del TP'),
        i(4, 'Nombre del TP'),
        i(5),
        i(6),
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
  s('item', t '\\item '),
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
          \includegraphics[width={}\linewidth{{{}}}
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
