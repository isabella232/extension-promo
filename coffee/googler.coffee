# interactive google search browser widget

Observable = require 'o_0'
googlerTemplate = require '../templates/googler'
searchData = require './searchData'

model =
	value: Observable ''
	state: Observable 'steel'
	googleResults: Observable []
	likeastoreResults: Observable []

	startMovie: ->
		@type 'Search request for something you have liked before...'

	installExtension: ->
		console.log 'check browser and go to download page'

	type: (text, n = 0) ->
		@state 'typing'
		if n < text.length
			n++

			@value text.substring(0, n)
			setTimeout (=>
				@type text, n
			), 100
		else
			setTimeout (=>
				@state 'highlight'
				@relayout()
			), 1000
	relayout: ->
		setTimeout (=>
			@state 'relayout'
			@googleResults searchData.googleResults
			@likeastoreResults searchData.likeastoreResults
		), 200

exports.init = ->
	view = document.getElementById 'googler'
	view.appendChild googlerTemplate(model)
