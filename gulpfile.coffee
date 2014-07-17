gulp = require 'gulp'
connect = require 'gulp-connect'
stylus = require 'gulp-stylus'
dookie = require 'dookie-css'

port = process.env.PORT or 9091

gulp.task 'styles', ->
	return gulp.src('./stylus/**/*.styl')
		.pipe(stylus compress: true, use: [dookie.css()], errors: true)
		.pipe(gulp.dest './client/css')

gulp.task 'connect', ->
	connect.server root: './client', port: port

gulp.task 'watch', ->
	gulp.start ['styles', 'server']
	gulp.watch ['./stylus/**/*.styl'], ['styles']

gulp.task 'server', ['connect']
gulp.task 'build', ['styles']
