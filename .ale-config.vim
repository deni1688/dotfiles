let aleLinterConfig = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'jsx': ['eslint'],
\   'typescript': ['eslint'],
\   'json': ['prettier'],
\   'go': ['gofmt'],
\}
let g:ale_linters = aleLinterConfig
let g:ale_fixers = aleLinterConfig
let b:ale_linters = aleLinterConfig
let b:ale_fixers = aleLinterConfig
let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
