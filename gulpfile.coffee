gulp = require 'gulp'
connect = require 'gulp-connect'
stylus = require 'gulp-stylus'
uglify = require 'gulp-uglifyjs'
rename = require 'gulp-rename'
hamlet = require 'gulp-hamlet-compile'
browserify = require 'gulp-browserify'
dookie = require 'dookie-css'

port = process.env.PORT or 9091

gulp.task 'styles', ->
	gulp.src('./stylus/**/*.styl')
		.pipe(stylus compress: true, use: [dookie.css()], errors: true)
		.pipe(gulp.dest './client/css')

gulp.task 'hamlet', ->
	gulp.src('./templates/**/*.haml')
		.pipe(hamlet())
		.pipe(gulp.dest './templates')

gulp.task 'browserify', ->
	gulp.src('./coffee/app.coffee', read: false)
		.pipe(browserify
			extensions: ['.coffee']
			transform: ['coffeeify']
		)
		.pipe(rename 'bundle.js')
		.pipe(gulp.dest './client/js')

gulp.task 'uglify', ->
	gulp.src('./client/js/bundle.js')
		.pipe(uglify())
		.pipe(rename 'bundle.min.js')
		.pipe(gulp.dest './client/js')

gulp.task 'connect', ->
	connect.server root: './client', port: port

gulp.task 'watch', ->
	gulp.run ['build', 'server']
	gulp.watch ['./coffee/**/*.coffee', './templates/**/*.haml'], ['hamlet', 'browserify']
	gulp.watch './stylus/**/*.styl', ['styles']

gulp.task 'server', ['connect']
gulp.task 'build', ['styles', 'hamlet', 'browserify', 'uglify']
gulp.task 'default', ['watch']
