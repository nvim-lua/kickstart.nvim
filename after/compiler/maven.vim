let current_compiler = "maven"

CompilerSet makeprg=mvn\ -B\ $*

" The errorformat for recognize following errors
" 1. Error due to POM file
" 2. Compliation error
" 	2.1. Ignore the lines after '[INFO] BUILD FAILURE' because the error message of
" 		compiler has been perceived before it.
" 3. Warning
" 4. Errors for unit test
"

" Ignored message
CompilerSet errorformat=
	\%-G[INFO]\ %.%#,
	\%-G[WARNING]\ %.%#,
	\%-G[debug]\ %.%#,
	\%-GWARNING:\ %.%#,
	\%-G%.%#on\ the\ class\ %.%#,
	\%-G%.%#unless\ at\ least\ %.%#,
	\%-G%.%#path\ is\ specified\ %.%#,
	\%-G%.%#processing\ is\ enabled\ %.%#,
	\%-G%.%#Use\ -Xlint%.%#,
	\%-G%.%#Use\ -proc%.%#,
	\%-G%\\d%\\+%.%#,
	\%-G\\s%#,
	\%-G\[ERROR]\ Failed\ to\ execute\ goal%.%#,
	\%-G\[ERROR]\ Please\ refer\ to\ %.%#,
	\%-G\[ERROR]\ ->\ \[Help\ 1]%.%#,
	\%-G\[ERROR]\ To\ see\ the\ full\ stack\ trace%.%#,
	\%-G\[ERROR]\ Re-run\ Maven\ using\ the\ -X\ switch%.%#,
	\%-G\[ERROR]\ For\ more\ information\ about\ the\ errors%.%#,
	\%-G\[ERROR]\ \[Help\ 1]\ http%.%#,
	\%-G\[ERROR]\ 

" Error message for POM
CompilerSet errorformat+=
	\[FATAL]\ Non-parseable\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#,
	\[%tRROR]\ Malformed\ POM\ %f:\ %m%\\s%\\+@%.%#line\ %l\\,\ column\ %c%.%#

" Error message for compiling
CompilerSet errorformat+=
	\[%tARNING]\ %f:[%l\\,%c]\ %m,
	\[%tRROR]\ %f:[%l\\,%c]\ %m

" Message from JUnit 5(5.3.X), TestNG(6.14.X), JMockit(1.43), and AssertJ(3.11.X)
CompilerSet errorformat+=
	\%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ FAILURE!,
	\%+E%>[ERROR]\ %.%\\+Time\ elapsed:%.%\\+<<<\ ERROR!,
	\%+Z%\\s%#at\ %f(%\\f%\\+:%l),
	\%+C%.%#
