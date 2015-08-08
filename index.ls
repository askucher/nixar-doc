Github = require \github-api
github = new Github do 
  token: "f05bc5885f17f05d984ec5f22e71d663ef52d2d" + "7"
  auth: "oauth"
user = github.get-user!
p = require \prelude-ls
beautify = require('js-beautify').js_beautify
fs = require \fs
require(\sync) ->
 gists = user.user-gists.sync null, \askucher
 transform = (box)->
    name: box.name
    files: box.gist.read.sync(null).files |> p.obj-to-pairs |> p.map (-> it.1.content)
 apply = (gist)->
     json = JSON.stringify(gist, null, 4)
     name = "#{process.cwd!}/node_modules/nixar/docs/#{gist.name}.js"
     console.log name
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