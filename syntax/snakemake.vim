" Vim syntax file
" Language: Snakemake (extended from python.vim)
" Maintainer: Jay Hesselberth (jay.hesselberth@gmail.com)
" Last Change: 2020 Oct 6
"
" Usage
"
" copy to $HOME/.vim/syntax directory and
" copy to ftdetect/snakemake.vim to $HOME/.vim/ftdetect directory
"
" force coloring in a vim session with:
"
" :set syntax=snakemake
"
if exists("b:current_syntax")
    finish
endif

" load settings from system python.vim (7.4)
source $VIMRUNTIME/syntax/python.vim
source $VIMRUNTIME/indent/python.vim

"
" Snakemake rules, as of version 5.8
"
"
" rule        = "rule" (identifier | "") ":" ruleparams
" include     = "include:" stringliteral
" workdir     = "workdir:" stringliteral
" ni          = NEWLINE INDENT
" ruleparams  = [ni input] [ni output] [ni params] [ni message] [ni threads] [ni (run | shell)] NEWLINE snakemake
" input       = "input" ":" parameter_list
" output      = "output" ":" parameter_list
" params      = "params" ":" parameter_list
" message     = "message" ":" stringliteral
" threads     = "threads" ":" integer
" resources   = "resources" ":" parameter_list
" version     = "version" ":" statement
" run         = "run" ":" ni statement
" shell       = "shell" ":" stringliteral
" singularity = "singularity" ":" stringliteral
" conda       = "conda" ":" stringliteral
" shadow      = "shadow" ":" stringliteral
" group       = "group" ":" stringliteral


" general directives (e.g. input)
syn keyword pythonStatement 
      \ benchmark
      \ conda
      \ configfile
      \ container
      \ default_target
      \ envmodules
      \ group
      \ include
      \ input
      \ localrule
      \ localrules
      \ log
      \ message
      \ notebook
      \ onerror
      \ onstart
      \ onsuccess
      \ output
      \ params
      \ priority
      \ resources
      \ ruleorder
      \ run
      \ scattergather
      \ script
      \ shadow
      \ shell
      \ singularity
      \ snakefile
      \ template_engine
      \ threads
      \ version
      \ wildcard_constraints
      \ wildcards
      \ workdir
      \ wrapper

" directives with a label (e.g. rule)
syn keyword pythonStatement 
      \ checkpoint
      \ rule
      \ subworkflow
      \ nextgroup=pythonFunction skipwhite

" common snakemake objects
syn keyword pythonBuiltinObj 
      \ Paramspace
      \ checkpoints
      \ config
      \ gather
      \ rules
      \ scatter
      \ workflow

" snakemake functions
syn keyword pythonBuiltinFunc 
      \ ancient
      \ directory
      \ expand
      \ multiext
      \ pipe
      \ protected
      \ read_job_properties
      \ service
      \ temp
      \ touch
      \ unpack

" similar to special def and class treatment from python.vim, except
" parenthetical part of def and class
syn match pythonFunction
      \ "\%(\%(rule\s\|subworkflow\s\|checkpoint\s\)\s*\)\@<=\h\w*" contained

syn sync match pythonSync grouphere NONE "^\s*\%(rule\|subworkflow\|checkpoint\)\s\+\h\w*\s*"

let b:current_syntax = "snakemake"

" vim:set sw=2 sts=2 ts=8 noet:
