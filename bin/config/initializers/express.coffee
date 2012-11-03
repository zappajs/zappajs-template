
# Express Configuration & Initialization
# ----------------------------------------------
# Here you should add all the config options
# for ExpressJS that match all your environments.
# 
@include = ->

	# Parse Request Bodies
	@use 'bodyParser'

	# RESTful Requests
	@use 'methodOverride'

	# Cookies
	@use @express.cookieParser(
		'YourSuperSecretSecretIsUltraStrongAndRandom'
	)

	# Require the Connect Redis Store for managing sessions
	RedisStore = require('connect-redis')(@express)

	# Sessions
	@use @express.session
		store: new RedisStore()

	# CSRF Protection. The CSRF token
	# is available as @session._csrf
	# in requests. Use it.
	# http://www.senchalabs.org/connect/middleware-csrf.html
	@use @express.csrf()

	# Router
	@use @app.router
