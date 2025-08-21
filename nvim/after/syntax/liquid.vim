" Custom Liquid syntax highlighting overrides
" This file loads AFTER the default liquid syntax

" Clear some default highlights to redefine them
hi clear liquidVariable

" HIGHEST PRIORITY: Variables being assigned (WHITE)
" These must be defined first to take precedence
syn match liquidAssignTarget "\(\<assign\s\+\)\@<=\w\+" contained containedin=liquidStatement
syn match liquidCaptureTarget "\(\<capture\s\+\)\@<=\w\+" contained containedin=liquidStatement  
syn match liquidForIterator "\(\<for\s\+\)\@<=\w\+" contained containedin=liquidStatement

" HIGH PRIORITY: Define Shopify global objects (PURPLE)
" Use \< and \> for word boundaries
syn match liquidGlobalVar "\<shop\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<product\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<collection\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<section\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<block\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<page\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<request\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<routes\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<settings\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<forloop\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<tablerowloop\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<paginate\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<form\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<cart\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<customer\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<linklists\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<handle\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<template\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<theme\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<all_products\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<articles\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<blogs\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<collections\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<pages\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<links\>" contained containedin=liquidStatement,liquidExpression
syn match liquidGlobalVar "\<site\>" contained containedin=liquidStatement,liquidExpression

" Properties after dots (WHITE)
syn match liquidDotProperty "\.\@<=\w\+" contained containedin=liquidStatement,liquidExpression

" Parameter names in render/include tags (GREEN)
syn match liquidParamName "\w\+:" contained containedin=liquidStatement

" LOWEST PRIORITY: Regular variables (ORANGE)
syn match liquidCustomVar "\<[a-zA-Z_][a-zA-Z0-9_]*\>" contained containedin=liquidStatement,liquidExpression

" Apply colors with forced priority
hi! liquidAssignTarget guifg=#F8F8F2
hi! liquidCaptureTarget guifg=#F8F8F2
hi! liquidForIterator guifg=#F8F8F2
hi! liquidGlobalVar guifg=#BD93F9
hi! liquidDotProperty guifg=#F8F8F2
hi! liquidParamName guifg=#50FA7B
hi! liquidCustomVar guifg=#FFB86C

" Override default liquidVariable
hi! link liquidVariable liquidCustomVar

" Strings should be yellow
hi! liquidString guifg=#F1FA8C
hi! liquidQuote guifg=#F1FA8C

" Numbers purple, booleans orange
hi! liquidNumber guifg=#BD93F9
hi! liquidFloat guifg=#BD93F9
hi! liquidBoolean guifg=#FFB86C
hi! liquidNull guifg=#FFB86C

" Keywords and operators
hi! liquidKeyword guifg=#BD93F9
hi! liquidConditional guifg=#BD93F9
hi! liquidOperator guifg=#FF79C6
hi! liquidPipe guifg=#FF79C6
hi! liquidFilter guifg=#8BE9FD

" Delimiters
hi! liquidDelimiter guifg=#FF79C6

" Comments
hi! liquidComment guifg=#6272A4