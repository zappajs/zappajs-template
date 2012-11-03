if process.env.NODE_ENV is 'production'
  port = 80
else
  port = 8080

require('zappajs') port, ->

  # Express Configurations for all environments
  @configure @include './config/initializers/express'
  
  @include './content.coffee'
