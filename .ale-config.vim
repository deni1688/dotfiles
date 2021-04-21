let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'jsx': ['eslint'],
\   'typescript': ['eslint'],
\   'json': ['prettier'],
\   'go': ['golint', 'go vet'],
\}
let b:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'jsx': ['eslint'],
\   'typescript': ['eslint'],
\   'json': ['prettier'],
\   'go': ['golint', 'go vet'],
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'jsx': ['eslint'],
\   'typescript': ['eslint'],
\   'json': ['prettier'],
\   'go': ['golint', 'go vet'],
\}
let b:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'javascriptreact': ['eslint'],
\   'typescriptreact': ['eslint'],
\   'typescript': ['eslint'],
\   'jsx': ['eslint'],
\   'json': ['prettier'],
\   'go': ['golint', 'go vet'],
\}
let g:ale_fix_on_save = 1
let g:ale_completion_autoimport = 1
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
