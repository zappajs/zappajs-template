# Cluster Initialization
#------------------------------------------#
# This script is an example of how you can
# start your zappa application in cluster
# mode.
# 
# We use the CommanderJS to parse command
# line arguments and boot up our app.
# https://github.com/visionmedia/commander.js/
# 
# Passing -c or --cluster will boot up our
# app in cluster mode with a worker per cpu
# core. If -c is not passed the app will
# boot up in a single core mode.
# 
# It's recommended to use a package like
# nodemon or forever to watch over your app
# files and restart the server on every change.
# https://github.com/nodejitsu/forever
# https://github.com/remy/nodemon
# 
# NOTE: This example will only work with NodeJS
# 0.8+. There were breaking changes in the
# cluster API between 0.6 and 0.8.
# 
# http://nodejs.org/api/cluster.html
# 
# Usage:
#   nodemon cluster.coffee --cluster
# 

program = require 'commander'
program
	.version('0.0.1')
	.option('-c --cluster', 'starts in cluster mode')
	.parse(process.argv)

cluster  = require 'cluster'
num_cpus = require('os').cpus().length
log      = console.log

# revive_worker logs the worker's death
# and starts a new worker.
# 
# See the cluster's exit event documentation:
# http://nodejs.org/api/cluster.html#cluster_event_exit
# 
revive_worker = (worker, code, signal) ->

	# Log the Death Sentence
	log "----------------------------------"
	log "Worker #{worker.process.pid} died."
	log "code: #{code}, signal: #{signal}"
	log "Starting a New Worker."
	log "----------------------------------"

	worker = cluster.fork().process
	listen_to worker


# listen_to listens to messages sent
# from the workers and logs them.
listen_to = (worker) ->
	worker.on 'message', (msg) ->
		log msg

# Handle all 3 cases:
# 1. Cluster Mode, Initialize the master
# 2. Cluster Mode, Initialize a worker
# 3. Single Mode, Initialize the app
if program.cluster
	# Start in Cluster Mode
	if cluster.isMaster
		# Start the Master
		log "Started in Master Mode"
		log "Forking #{num_cpus} workers"

		# Fork!
		for cpu in [1..num_cpus]
			worker = cluster.fork().process
			listen_to worker

		# Listen to Workers exit event (death)
		cluster.on 'exit', revive_worker

	else
		# Start a Worker
		log "Starting a Worker"
		app = require './server'


else
	# Start in Single Mode
	log "Started in Single Mode"
	app = require './server'
