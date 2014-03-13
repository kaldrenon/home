" Enable SQL syntax highlighting in Ruby heredocs
"let s:bcs = b:current_syntax
"unlet b:current_syntax
"syntax include @SQL syntax/sql.vim
"let b:current_syntax = s:bcs
"" match optional, surrounding single or double quote and any
"" whitespace in the heredoc name
"syntax region perlHereDocSQL matchgroup=Statement
"start=+<<\([-]\?\)\z(\s*SQL\s*\)\1+ end=+^\z1$+ contains=@SQL
