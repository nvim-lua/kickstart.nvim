local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

-- Template pour un document LaTeX
 return {
    s({trig="textemplate",snippetType="autosnippet"}, fmta([[
\documentclass[a4paper]{article}

% Packages pour les mathématiques et la langue française
\usepackage{amsmath, amssymb, amsfonts, amsthm}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[french]{babel}
\setlength{\parindent}{0pt} % Pas d'indentation en début de paragraphe

% Définitions des environnements pour les théorèmes, définitions, etc.
\newtheorem{definition}{Définition}
\newtheorem{proposition}{Proposition}

\title{<>}
\author{<>}
\date{\today}

\begin{document}

\maketitle % Génère le titre

\tableofcontents % Génère la table des matières

\section{<>}

\begin{definition}[<>]
    \vspace{5pt}
    <>
\end{definition}

\begin{proposition}
    \vspace{5pt}
    <>
\end{proposition}

\begin{proof}
    \vspace{5pt}
    <>
\end{proof}

\end{document}
]], {
        i(1, "Titre du document"), -- Titre du document
        i(2, "Ton Nom"), -- Auteur
        i(3, "Titre de la section"), -- Titre de la première section
        i(4, "Nom de la définition"), -- Nom de la définition
        i(5, "Contenu de la définition"), -- Contenu de la définition
        i(6, "Contenu de la proposition"), -- Contenu de la proposition
        i(7, "Contenu de la preuve"), -- Contenu de la preuve
    })),
}

