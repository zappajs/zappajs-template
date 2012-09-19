if process.env.NODE_ENV is 'production'
  port = 80
else
  port = 8080

require('zappajs') port, ->

  @get '/': 'hello world, from zappajs'
