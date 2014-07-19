# interactive google search browser widget

googlerTemplate = require '../templates/googler'
Observable = require 'o_0'

model =
	value: Observable ''
	state: Observable 'typing'

	type: (text, n = 0) ->
		if n < text.length
			n++

			@value text.substring(0, n)
			setTimeout =>
				@type text, n
			, 100
		else
			setTimeout =>
				@state 'highlight'
				@relayout()
			, 1000
	relayout: ->
		setTimeout =>
			@state 'relayout'
		, 200

exports.init = ->
	view = document.getElementById 'googler'
	view.appendChild googlerTemplate(model)
	model.type 'Search request for something you have liked before...'
