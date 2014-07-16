gulp = require 'gulp'
connect = require 'gulp-connect'

port = process.env.PORT or 9091

gulp.task 'connect', ->
	connect.server root: './client', port: port

gulp.task 'server', ['connect']
