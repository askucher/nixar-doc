module.exports = function(repo) {
  repo.docs.push({
    "name": "after",
    "files": [
      "<p>Native Command\n<code>sh\n$ echo \"1.2.3.4.5\" | sed  s/1.//g   #=&gt; \"2.3.4.5\" <br />\n</code></p>",
      "<h3>Print the string after a substring</h3>\n\n<p>Command\n<code>sh\n$ echo \"1.2.3.4.5\" |  after \".\"  #=&gt; \"2.3.4.5\"\n</code></p>"
    ]
  });
}