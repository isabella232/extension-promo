# interactive google search browser widget

googlerTemplate = require '../templates/googler'
Observable = require 'o_0'

model =
	value: Observable 'abc'
	type: (text, n = 0) ->
		unless n >= text.length
			@value text.substring(0, n+1)
			n++;

			setTimeout () =>
				@type text, n
			, 100

exports.init = ->
	view = document.getElementById 'googler'
	view.appendChild googlerTemplate(model)
	model.type 'Search request for something you have liked before...'
