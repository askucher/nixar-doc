Github = require \github-api
token = \f05bc5 + \885f17 + \f05d98 + \4ec5f2 + \2e71d663e + \f52d2d7
github = new Github do 
  username: \askucher
  password: \vtufgjkbc1
  auth: \basic
user = github.get-user!
p = require \prelude-ls
require(\sync) ->
 gists = user.user-gists.sync null, \digitorum333
 
 my-gists = user.gists.sync null
 transform = (box)->
    name: box.name
    files: box.gist.read.sync(null).files
 apply = (gist)->
     #return if gist.name isnt \fs
     req = 
          description: "nixar.#{gist.name}"
          files: gist.files
          public: yes
     #console.log req
     resp = 
        github.getGist(null).create.sync null, req 
     resp.for-each (err, data)->
        console.log data 
     # * req
     #    * (err)->
     #         console.log \done, gist.name
     #         console.log err
 
 delete-gist = (gist)->
     github.getGist(it.id).delete(-> )
 for-del = my-gists.filter(-> it.description?index-of(\nixar) > -1)
 console.log "Going to delete", for-del.length, "gists"
 #for-del.for-each delete-gist
 #console.log \deleted
 gists
   .filter(-> it.description.index-of(\nixar) > -1)
   .map(-> name: it.description.split(\.).1, id: it.id)
   .map(-> gist: github.get-gist(it.id), name: it.name )
   .map(transform)
   .for-each apply
 console.log \inserted