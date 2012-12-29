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
		$(@canvas).bind "mousedown touchstart", (e)=>
			@_mouseDown(e)
		$(window).bind "mouseup touchend", (e)=>
			@_mouseUp(e)
	disable: ->
		$(window).unbind "mousewheel DOMMouseScroll"
		$(@canvas).unbind "mousedown touchstart"
		$(window).unbind "mouseup touchend"
		$(window).unbind "mousemove touchmove"
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
		cX = e.clientX || (e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]).pageX
		cY = e.clientY || (e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]).pageY
		

		# knob drag
		if @knob.containsPoint(cX, cY) || Modernizr.touch #Touch enabled devices scroll even when not clicking on the scrollbar
			@knob.clickOffset = cY - @knob.y
			$(window).bind('mousemove touchmove', (ev)=> @_mouseMove(ev))
	_mouseUp: (e)->
		$(window).unbind('mousemove touchmove')
	_mouseMove: (e)->
		cY = e.clientY || (e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]).pageY
		@_moveKnobY(cY - @knob.clickOffset)
		e.preventDefault()
	# User scroll interaction
	_scroll: (e)->
		@_moveKnobY(@knob.y + (e.originalEvent.wheelDelta || -e.originalEvent.detail))
		e.preventDefault()
		

class DefaultScrollbar extends Scrollbar
	width: 18,
	knobMargin: 18

	constructor: (@canvas) ->

		super(@canvas)

		# Prepare scroll elements
		@knob = new createjs.Rectangle(0, @knobMargin, @width, 250)
		@upRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@upImage = new Image()
		@upImage.src = "images/defaultScrollUp.jpg"
		@downRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@downImage = new Image()
		@downImage.src = "images/defaultScrollDown.jpg"

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

	_mouseUp: (e)->
		$(window).unbind('mousemove touchmove')

		cX = e.clientX || (e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]).pageX
		cY = e.clientY || (e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]).pageY

		# Scroll up click
		if @upRect.containsPoint(cX, cY)
			@_moveKnobY(@knob.y - 15)
		# Scroll down click
		else if @downRect.containsPoint(cX, cY)
			@_moveKnobY(@knob.y + 15)

class WinScrollbar extends Scrollbar
	width: 15,
	knobMargin: 18

	constructor: (@canvas) ->

		super(@canvas)

		# Prepare scroll elements
		@knob = new createjs.Rectangle(0, @knobMargin, @width, 250)
		@upRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@upImage = new Image()
		@upImage.src = "images/winScrollUp.jpg"
		@downRect = new createjs.Rectangle(0, 0, @width, @knobMargin)
		@downImage = new Image()
		@downImage.src = "images/winScrollDown.jpg"

	draw: ->
		# Scroll BG
		@ctx.fillStyle = "#f0f0f0"
		@ctx.fillRect(@knob.x-1, 0, @knob.width+1, @canvas.height)

		# Scroll bar
		grd = @ctx.createLinearGradient(@knob.x, 0, @knob.x + @knob.width, 0)
		grd.addColorStop(0,"#f5f5f5")
		grd.addColorStop(0.5,"#e9e9eb")
		grd.addColorStop(0.5,"#d9dadc")		
		grd.addColorStop(1,"#cfcfd1")

		x = @knob.x+1; y = @knob.y
		width = @knob.width-1; height = @knob.height
		radius = 2

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
		@ctx.fillStyle = grd
		@ctx.fill()

		x -= 0.5; y -= 0.5
		
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
		@ctx.lineWidth = 1
		@ctx.strokeStyle = "#979797"
		@ctx.stroke()

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

	_mouseUp: (e)->
		$(window).unbind('mousemove touchmove')

		cX = e.clientX || (e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]).pageX
		cY = e.clientY || (e.originalEvent.touches[0] || e.originalEvent.changedTouches[0]).pageY

		# Scroll up click
		if @upRect.containsPoint(cX, cY)
			@_moveKnobY(@knob.y - 15)
		# Scroll down click
		else if @downRect.containsPoint(cX, cY)
			@_moveKnobY(@knob.y + 15)


window.WinScrollbar = WinScrollbar
window.DefaultScrollbar = DefaultScrollbar
window.Scrollbar = Scrollbar

# Helper
createjs.Rectangle.prototype.containsPoint = (x, y)->
	(x >= @x && y >= @y && x <= @x + @width && y <= @y + @height)