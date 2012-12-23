class WinScrollbar
	width: 18,
	knobMargin: 18

	constructor: (@canvas) ->

		# Prepare scroll elements
		@knob = new createjs.Rectangle(0, @knobMargin, @width, 250)
		@upRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@upImage = new Image()
		@upImage.src = "images/scrollUp.jpg"
		@downRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@downImage = new Image()
		@downImage.src = "images/scrollDown.jpg"

		# Draw into this context
		@ctx = @canvas.getContext '2d'

	draw: ->
		@ctx.fillStyle = "#eeeeee"
		@ctx.fillRect(@knob.x, 0, @knob.width, @canvas.height)
		@ctx.fillStyle = "#c0c0c0"
		@ctx.fillRect(@knob.x + 2, @knob.y + 2, @knob.width - 2, @knob.height)
		@ctx.lineWidth = 1
		@ctx.strokeStyle = "#808080"
		@ctx.strokeRect(@knob.x + 0.5, @knob.y + 0.5, @knob.width - 1, @knob.height)
		# Top and bottom buttons
		@ctx.drawImage(@upImage, @canvas.width - @width, 0)
		@ctx.drawImage(@downImage, @downRect.x, @downRect.y)

	reset: ->
		@knob.y = @knobMargin

	# Enable and disable scroll interaction by managing it's events
	enable: ->
		$(window).bind "mousewheel DOMMouseScroll", (e)=>
			@_scroll(e)
		$(@canvas).bind "mousedown", (e)=>
			@_mouseDown(e)
		$(@canvas).bind "mouseup", (e)=>
			@_mouseUp(e)
	disable: ->
		$(window).unbind "mousewheel DOMMouseScroll"
		$(@canvas).unbind "mousedown"
		$(@canvas).unbind "mouseup"

	# User scroll interaction
	_scroll: (e)->
		@_moveKnobY(@knob.y + (e.originalEvent.wheelDelta || -e.originalEvent.detail))
		e.preventDefault()
	_mouseDown: (e)->
		# knob drag
		if @scrollKnob.containsPoint(e.clientX, e.clientY)
			@scrollKnob.clickOffset = e.clientY - @scrollKnob.y
			$(@canvas).bind('mousemove', (ev)=> @_mouseMove(ev))
	_mouseUp: (e)->
		$(@canvas).unbind('mousemove')

		# Scroll up click
		if @scrollUpRect.containsPoint(e.clientX, e.clientY)
			@_moveKnobY(@scrollKnob.y - 15)
		# Scroll down click
		else if @scrollDownRect.containsPoint(e.clientX, e.clientY)
			@_moveKnobY(@scrollKnob.y + 15)
	_mouseMove: (e)->
		@_moveKnobY(e.clientY - @scrollKnob.clickOffset)
	_moveKnobY: (y)->
		@knob.y = y
		@knob.y = @knobMargin if @knob.y < @knobMargin
		@knob.y = @canvas.height - @knobMargin - @knob.height if @knob.y > @canvas.height - @knob.height - @knobMargin
		$(@).trigger('knobmove')

	# Window resizing
	resize: ->
		# Set elements positions (align)
		@knob.x = 
		@upRect.x =
		@downRect.x =
			@canvas.width - @width
		@downRect.y = @canvas.height - @knobMargin

# class Scrollbar extends Scrollbar
# 	constructor: (@canvas) ->
# 		super(@canvas)

window.WinScrollbar = WinScrollbar
# window.Scrollbar = Scrollbar

# Helper
createjs.Rectangle.prototype.containsPoint = (x, y)->
	(x >= @x && y >= @y && x <= @x + @width && y <= @y + @height)