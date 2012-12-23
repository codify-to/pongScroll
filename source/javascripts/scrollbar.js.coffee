class Scrollbar
	width: 10,
	knobMargin: 0,
	constructor: (@canvas) ->
		@knob = new createjs.Rectangle(0, @knobMargin, @width, 250)
		@ctx = @canvas.getContext '2d'

	# Window resizing
	resize: ->
		# Set elements positions (align)
		@knob.x = @canvas.width - @width
	draw: ->
		@ctx.clearRect(@knob.x + 3, @knob.y, @knob.width - 5, @knob.height)

		x = @knob.x+2; y = @knob.y
		width = @knob.width-5; height = @knob.height
		radius = 3

		@ctx.beginPath();
		@ctx.moveTo(x + radius, y);
		@ctx.lineTo(x + width - radius, y);
		@ctx.quadraticCurveTo(x + width, y, x + width, y + radius);
		@ctx.lineTo(x + width, y + height - radius);
		@ctx.quadraticCurveTo(x + width, y + height, x + width - radius, y + height);
		@ctx.lineTo(x + radius, y + height);
		@ctx.quadraticCurveTo(x, y + height, x, y + height - radius);
		@ctx.lineTo(x, y + radius);
		@ctx.quadraticCurveTo(x, y, x + radius, y);
		@ctx.closePath();

		@ctx.fillStyle = "rgba(0,0,0,0.6)"
		@ctx.fill()
		
		# @ctx.fillRect(@knob.x + 3, @knob.y, @knob.width - 5, @knob.height)

	# Enable and disable scroll interaction by managing it's events
	enable: ->
		$(window).bind "mousewheel DOMMouseScroll", (e)=>
			@_scroll(e)
		$(@canvas).bind "mousedown", (e)=>
			@_mouseDown(e)
		$(window).bind "mouseup", (e)=>
			@_mouseUp(e)
	disable: ->
		$(window).unbind "mousewheel DOMMouseScroll"
		$(@canvas).unbind "mousedown"
		$(window).unbind "mouseup"
		$(window).unbind "mousemove"
	# 
	reset: ->
		@knob.y = @knobMargin

	# Move the knob in Y axis
	# This will trigger events
	_moveKnobY: (y)->
		@knob.y = y
		@knob.y = @knobMargin if @knob.y < @knobMargin
		@knob.y = @canvas.height - @knobMargin - @knob.height if @knob.y > @canvas.height - @knob.height - @knobMargin
		$(@).trigger('knobmove')

	# 
	# Internal mouse management stuff
	# 
	_mouseDown: (e)->
		# knob drag
		if @knob.containsPoint(e.clientX, e.clientY)
			@knob.clickOffset = e.clientY - @knob.y
			$(window).bind('mousemove', (ev)=> @_mouseMove(ev))
	_mouseUp: (e)->
		$(window).unbind('mousemove')

		# Scroll up click
		if @upRect.containsPoint(e.clientX, e.clientY)
			@_moveKnobY(@knob.y - 15)
		# Scroll down click
		else if @downRect.containsPoint(e.clientX, e.clientY)
			@_moveKnobY(@knob.y + 15)
	_mouseMove: (e)->
		@_moveKnobY(e.clientY - @knob.clickOffset)
	# User scroll interaction
	_scroll: (e)->
		@_moveKnobY(@knob.y + (e.originalEvent.wheelDelta || -e.originalEvent.detail))
		e.preventDefault()
		

class WinScrollbar extends Scrollbar
	width: 18,
	knobMargin: 18

	constructor: (@canvas) ->

		super(@canvas)

		# Prepare scroll elements
		@knob = new createjs.Rectangle(0, @knobMargin, @width, 250)
		@upRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@upImage = new Image()
		@upImage.src = "images/scrollUp.jpg"
		@downRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@downImage = new Image()
		@downImage.src = "images/scrollDown.jpg"

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

	# Window resizing
	resize: ->
		# Set elements positions (align)
		@knob.x = 
		@upRect.x =
		@downRect.x =
			@canvas.width - @width
		@downRect.y = @canvas.height - @knobMargin

window.WinScrollbar = WinScrollbar
window.Scrollbar = Scrollbar

# Helper
createjs.Rectangle.prototype.containsPoint = (x, y)->
	(x >= @x && y >= @y && x <= @x + @width && y <= @y + @height)