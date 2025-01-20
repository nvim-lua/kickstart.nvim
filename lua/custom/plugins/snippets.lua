local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require('luasnip.extras').rep
local fmt = require('luasnip.extras.fmt').fmt

return {
  -- Snippet pour la déclaration de fonction Tcl
  tcl = {
    s('proc', {
      t 'proc ', -- Texte fixe : "proc "
      i(1, 'func'), -- Point d'insertion pour le nom de la fonction, valeur par défaut : "func"
      t ' {} {', -- Texte fixe : " {} {"
      t { '', '\t' }, -- Nouvelle ligne et indentation
      i(2, '# body'), -- Point d'insertion pour le corps de la fonction
      t { '', '}' }, -- Nouvelle ligne pour fermer les accolades
    }),
    s('for', {
      t 'for {set i ', -- Texte fixe : "for {set i "
      i(1, '0'), -- Point d'insertion pour la valeur initiale (par défaut '0')
      t '} {', -- Texte fixe : '} {'
      i(2, '$i < 10'), -- Point d'insertion pour la condition (par défaut '$i < 10')
      t { '} {incr i} {', '' }, -- Texte fixe : '} {incr i} {'
      i(3, '\t# body'), -- Point d'insertion pour le corps de la boucle
      t { '', '}' }, -- Texte fixe pour fermer la boucle
    }),
    s('if', { -- Nom du trigger : "if"
      t 'if {', -- Texte statique pour commencer le `if`
      i(1, 'cond'), -- Premier champ éditable pour la condition
      t '} {', -- Texte statique pour l'ouverture du bloc
      t { '', '    ' }, -- Nouvelle ligne avec indentation
      i(2, '#body'), -- Deuxième champ éditable pour le corps
      t { '', '}' }, -- Nouvelle ligne avec fermeture du bloc
    }),
    s('foreach', { -- Nom du trigger : "foreach"
      t 'foreach {', -- Texte statique pour commencer
      i(1, 'var'), -- Premier champ éditable pour la variable
      t '} $', -- Espace statique
      i(2, 'list'), -- Deuxième champ éditable pour la liste
      t ' {', -- Début du bloc
      t { '', '    ' }, -- Nouvelle ligne avec indentation
      i(3, '#body'), -- Troisième champ éditable pour le corps
      t { '', '}' }, -- Nouvelle ligne avec fermeture du bloc
    }),
    s('unit_test', {
      t 'set res ',
      i(1, '@'),
      t { '', 'set expected ' },
      i(2, '@'),
      t { '', 'set name ' },
      i(3, '@'),
      t { '', 'if {$res == $expected } {', '' },
      t { '\tputs "test \\#[incr counter] \\"$name\\" passed"} else {', '' },
      t { '\tputs "test \\#[incr counter] \\"$name\\" not passed\\nres : $res\\nexpected : $expected"', '' },
      t '}',
    }),
  },
  -- Déclaration de snippet typst
  typst = {
    s('image', {
      t { '#figure(caption: "' },
      i(1, 'caption'),
      t { '")[', '' },
      t { '  #image("' },
      i(2, 'path'),
      t { '")', '' },
      t { ']' },
    }),
    s('image_paysage', {
      t { '#page(flipped:true)[', '  #figure(caption: "' },
      i(1, ''),
      t { '")[', '    #align(center + horizon)[#image("' },
      i(2, ''),
      t { '")]', '  ]', ']' },
    }),
    s('code_fig', {
      t { '#figure(caption:"' },
      i(1, 'Légende'),
      t { '")[```', '' },
      i(2, 'Contenu'),
      t { '', '```]' },
    }),
  },
  c = {
    s('main', {
      t { '#include <stdio.h>', '', 'int main(int argc, char *argv[]) {' },
      t { '', '    ' },
      i(1, '// Votre code ici'),
      t { '', '', '    return 0;', '}' },
    }),
    s('if', {
      t { 'if (' },
      i(1, 'condition'),
      t { ') {', '    ' },
      i(2, '// Code'),
      t { '', '}' },
    }),
    s('for', {
      t { 'for (int ' },
      i(1, 'i = 0'),
      t { '; ' },
      i(2, 'i < n'),
      t { '; ' },
      i(3, 'i++'),
      t { ') {', '    ' },
      i(4, '// Code'),
      t { '', '}' },
    }),
    s('while', {
      t { 'while (' },
      i(1, 'condition'),
      t { ') {', '    ' },
      i(2, '// Code'),
      t { '', '}' },
    }),
    s('func', {
      i(1, 'type'),
      t { ' ' },
      i(2, 'function_name'),
      t { '(' },
      i(3, 'parameters'),
      t { ') {', '    ' },
      i(4, '// Code'),
      t { '', '}' },
    }),
  },
  c_header = {
    s('header', {
      t { '#ifndef ' },
      i(1, 'FOO'),
      t { '', '#define ' },
      rep(1),
      t { '', 'int foo(int x);  /* An example function declaration */', '', '#endif' },
    }),
  },
  bib = {
    s('online', {
      t { '@online{' },
      i(1, 'citekey'),
      t { ',', '\tauthor = {' },
      i(2, 'Author Name'),
      t { '},' },
      t { '', '\ttitle = {' },
      i(3, 'Title of Webpage'),
      t { '},' },
      t { '', '\turl = {' },
      i(4, 'https://example.com'),
      t { '},' },
      t { '', '\turldate = {' },
      i(5, '2025-01-08'),
      t { '}', '}' },
    }),
  },
  js = {
    s('func', {
      t { 'function ' },
      i(1, 'functionName'),
      t '() {',
      t { '', '  ' },
      i(2, '// code'),
      t { '', '}' },
    }),

    -- If statement snippet
    s('if', {
      t { 'if (' },
      i(1, 'condition'),
      t ') {',
      t { '', '  ' },
      i(2, '// code'),
      t { '', '}' },
    }),

    -- For loop snippet
    s('for', {
      t { 'for (let ' },
      i(1, 'i'),
      t ' = ',
      i(2, '0'),
      t '; ',
      i(3, 'i'),
      t ' < ',
      i(4, '10'),
      t '; ',
      i(5, 'i'),
      t '++) {',
      t { '', '  ' },
      i(6, '// code'),
      t { '', '}' },
    }),

    -- While loop snippet
    s('while', {
      t { 'while (' },
      i(1, 'condition'),
      t ') {',
      t { '', '  ' },
      i(2, '// code'),
      t { '', '}' },
    }),

    -- Foreach snippet
    s('foreach', {
      i(1, 'array'),
      t '.forEach(',
      i(2, 'element'),
      t ' => {',
      t { '', '  ' },
      i(3, '// code'),
      t { '', '});' },
    }),
    s('javadoc', {
      t { '/**', ' * ' },
      i(1, 'Description...'),
      t { '', ' * ', ' * @param ' },
      i(2, 'paramName'),
      t ' ',
      i(3, 'description of parameter'),
      t { '', ' * @return ' },
      i(4, 'description of return value'),
      t { '', ' */' },
    }),
  },
}
