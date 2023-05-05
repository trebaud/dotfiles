* execute visual selection in bash and append output to current buffer:

`:'<,'>w !bash >> %`

or with xargs (better)

`:'<,'>w !xargs -I{} sh -c 'echo "----" && {}' >> %`

* send visual selection as a param to bash command and replace it with output, example with base64 decoding:

`:'<,'>!xargs -I{} sh -c 'echo {}|base64 -d'`

* filter lines with pattern within current buffer

`:%!grep 'pattern'`

* filter out lines with pattern within current buffer

`:%!grep -v 'pattern'`
