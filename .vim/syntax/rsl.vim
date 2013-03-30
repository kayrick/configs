if exists("b:current_syntax")
	finish
endif

"
" Types: Bool, Int, Nat, Real, Char, Text, Unit
" Consts: true, false, chaos
" Built-in ops: abs, real, len
" Statements: if, then, else, do, while, until
" Quantifier: all, exists, exists!
"

syntax case match

syn region rslComment start="--" skip="\\$" end="$"
syn keyword rslType Int Nat Real Bool Char Unit
syn match rslArrayType '\(-list\|-inflist\)'
syn match rslSetType '\(-set\|-infset\)'
syn keyword rslConsts true false chaos
syn keyword rslStatements do while until if then else end let for case elsif
syn keyword rslQuantifier all exists
syn keyword rslModule scheme class 
syn keyword rslDefinition value axiom variable channel type local
syn keyword rslCond pre post
syn keyword rslTags as in is of isin
syn match rslOperator '\(-m->\|:=\|\\\/\|\/\\\|->\|-\~->\|><\|+>\)'
syn keyword rslBuiltIn len abs int real dom elems inds tl hd card rng

hi def link rslConsts Comment
hi def link rslType Type
hi def link rslArrayType Type
hi def link rslSetType Type
hi def link rslConsts Constant
hi def link rslOperator Operator
hi def link rslBuiltIn Operator
hi def link rslStatements Statement
hi def link rslQuantifier Keyword
hi def link rslModule Keyword
hi def link rslDefinition Define
hi def link rslCond Conditional
hi def link rslTags Tag


let b:current_syntax = "RSL"


