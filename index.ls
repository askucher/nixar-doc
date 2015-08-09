Github = require \github-api
github = new Github do 
  token: \f05bc5 + \885f17 + \f05d98 + \4ec5f2 + \2e71d663e + \f52d2d7
  auth: \oauth
user = github.get-user!
p = require \prelude-ls
beautify = require(\js-beautify).js_beautify
md = require(\node-markdown).Markdown
fs = require \fs
require(\sync) ->
 gists = user.user-gists.sync null, \askucher
 transform = (box)->
    name: box.name
    files: box.gist.read.sync(null).files |> p.obj-to-pairs |> p.map (-> it.1.content)
 apply = (gist)->
     json =
         JSON.stringify do 
             * name: gist.name
               files: gist.files.map(md)
             * null
             * 4
     fs.write-file-sync do
        * "#{process.cwd!}/node_modules/nixar/docs/#{gist.name}.js"
        * beautify do
            * "module.exports = function(repo) { repo.docs.push(#json); }"
            * indent_size: 2
        * \utf8
 gists
   .filter(-> it.description.index-of(\nixar) > -1)
   .map(-> name: it.description.split(\.).1, id: it.id)
   .map(-> gist: github.get-gist(it.id), name: it.name )
   .map(transform)
   .for-each apply