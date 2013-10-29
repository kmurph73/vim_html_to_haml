Convert your html to haml

if [vim-eunuch][1] is installed 'erb' is in the filename, it will be gsubbed with 'haml'

make sure the html2haml gem is installed and the 'html2haml' binary in your current $PATH

Just execute

    :ConvertToHaml

while on the buffer you want to convert to haml.

In visual mode, you can convert the current selection to haml by hitting

    <c-v>

TODO:

* vim-repeat support
* convert multiple files to haml
* get feedback on code? (first Vim plugin)

[1]: https://github.com/tpope/vim-eunuch
