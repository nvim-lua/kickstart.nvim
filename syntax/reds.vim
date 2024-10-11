" Vim syntax file
" Language:	Red/System
" Maintainer:	David Feng <davidxifeng@gmail.com>
" Filenames:	*.reds
" Last Change:	2017-09-03
" URL:		https://github.com/DavidFeng/vim-red
"

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Red/System is case insensitive
syn case ignore

setlocal iskeyword=@,48-57,?,!,.,',+,-,*,&,\|,=,_,~

syn keyword	redsTodo	contained TODO

" Comments
syn match       redsComment    ";.*$" contains=redsTodo

" Words
syn match       redsWord       "\a\k*"
syn match       redsWordPath   "[^[:space:]]/[^[:space]]"ms=s+1,me=e-1

" Booleans
syn keyword     redsBoolean    true false on off yes no

" Values
" Integers
syn match       redsInteger    "\<[+-]\=\d\+\('\d*\)*\>"
" Decimals
syn match       redsFloat    "[+-]\=\(\d\+\('\d*\)*\)\=[,.]\d*\(e[+-]\=\d\+\)\="
syn match       redsFloat    "[+-]\=\d\+\('\d*\)*\(e[+-]\=\d\+\)\="
" Time
syn match       redsTime       "[+-]\=\(\d\+\('\d*\)*\:\)\{1,2}\d\+\('\d*\)*\([.,]\d\+\)\=\([AP]M\)\=\>"
syn match       redsTime       "[+-]\=:\d\+\([.,]\d*\)\=\([AP]M\)\=\>"
" Strings
syn region      redsString     oneline start=+"+ skip=+^"+ end=+"+ contains=redsSpecialCharacter
syn region      redsString     start=+[^#]{+ end=+}+ skip=+{[^}]*}+ contains=redsSpecialCharacter
" Binary
syn region      redsBinary     start=+\d*#{+ end=+}+ contains=redsComment
" File
syn match       redsFile       "%\(\k\+/\)*\k\+[/]\=" contains=redsSpecialCharacter
syn region      redsFile       oneline start=+%"+ end=+"+ contains=redsSpecialCharacter
" Issues
syn match	redsIssue	"#\(\d\+-\)*\d\+"
" Tuples
syn match	redsTuple	"\(\d\+\.\)\{2,}"

" Characters
syn match       redsSpecialCharacter contained "\^[^[:space:][]"
syn match       redsSpecialCharacter contained "%\d\+"


" Operators
" Math operators
syn match       redsMathOperator  "\(\*\{1,2}\|+\|-\|/\{1,2}\)"
syn keyword     redsMathFunction  abs absolute add arccosine arcsine arctangent cosine
syn keyword     redsMathFunction  divide exp log-10 log-2 log-e max maximum min
syn keyword     redsMathFunction  minimum multiply negate power random remainder sine
syn keyword     redsMathFunction  square-root subtract tangent
" Binary operators
syn keyword     redsBinaryOperator complement and or xor ~
" Logic operators
syn match       redsLogicOperator "[<>=]=\="
syn match       redsLogicOperator "<>"
syn keyword     redsLogicOperator not
syn keyword     redsLogicFunction all any
syn keyword     redsLogicFunction head? tail?
syn keyword     redsLogicFunction negative? positive? zero? even? odd?
syn keyword     redsLogicFunction binary? block? char? date? decimal? email? empty?
syn keyword     redsLogicFunction file? found? function? integer? issue? logic? money?
syn keyword     redsLogicFunction native? none? object? paren? path? port? series?
syn keyword     redsLogicFunction string? time? tuple? url? word?
syn keyword     redsLogicFunction exists? input? same? value?

" Datatypes
syn keyword     redsType       binary! block! char! date! decimal! email! file!
syn keyword     redsType       function! integer! issue! logic! money! native!
syn keyword     redsType       none! object! paren! path! port! string! time!
syn keyword     redsType       tuple! url! word!
syn keyword     redsTypeFunction type?

" Control statements
syn keyword     redsStatement  break catch exit halt reduce return shield
syn keyword     redsConditional if else either
syn keyword     redsRepeat     for forall foreach forskip loop repeat while until do

" Series statements
syn keyword     redsStatement  change clear copy fifth find first format fourth free
syn keyword     redsStatement  func function head insert last match next parse past
syn keyword     redsStatement  pick remove second select skip sort tail third trim length?

" Context
syn keyword     redsStatement  alias bind use

" Object
syn keyword     redsStatement  import make make-object reds info?

" I/O statements
syn keyword     redsStatement  delete echo form format import input load mold prin
syn keyword     redsStatement  print probe read save secure send write
syn keyword     redsOperator   size? modified?

" Debug statement
syn keyword     redsStatement  help probe trace

" Misc statements
syn keyword     redsStatement  func function free

" Constants
syn keyword     redsConstant   none


" Define the default highlighting.
" Only when an item doesn't have highlighting yet

hi def link redsTodo     Todo

hi def link redsStatement Statement
hi def link redsLabel	Label
hi def link redsConditional Conditional
hi def link redsRepeat	Repeat

hi def link redsOperator	Operator
hi def link redsLogicOperator redsOperator
hi def link redsLogicFunction redsLogicOperator
hi def link redsMathOperator redsOperator
hi def link redsMathFunction redsMathOperator
hi def link redsBinaryOperator redsOperator
hi def link redsBinaryFunction redsBinaryOperator

hi def link redsType     Type
hi def link redsTypeFunction redsOperator

hi def link redsWord     Identifier
hi def link redsWordPath redsWord
hi def link redsFunction	Function

hi def link redsCharacter Character
hi def link redsSpecialCharacter SpecialChar
hi def link redsString	String

hi def link redsNumber   Number
hi def link redsInteger  redsNumber
hi def link redsFloat	 redsNumber
hi def link redsTime     redsNumber
hi def link redsBinary   redsNumber
hi def link redsFile     redsString
hi def link redsIssue    redsNumber
hi def link redsTuple    redsNumber
hi def link redsFloat    Float
hi def link redsBoolean  Boolean

hi def link redsConstant Constant

hi def link redsComment	Comment

hi def link redsError	Error


let b:current_syntax = "reds"
