startTime = new Date

SCROLL_WIDTH = 20
KNOB_MARGIN_TOP = 40
KNOB_MARGIN_BOTTOM = 40

class Pong
	ballColor: "#1bc1ff"
	constructor: (@onStart, @onGameOver) ->
		
		# Get canvas
		@canvas = document.getElementById('game')
		@ctx = @canvas.getContext('2d')
		
		# Creating the left paddle (that the game controls)
		@gamePaddle = new createjs.Rectangle(20, 0, 30, 180)
		# Game's ball
		@ball = new createjs.Rectangle(20, 0, 30, 30)
		# Create scrollbar
		@scrollKnob = new createjs.Rectangle(0, KNOB_MARGIN_TOP, SCROLL_WIDTH, 180)
		
		# Creating the scrollbar

		# Setup enter frame
		createjs.Ticker.addListener @


		# Setup listeners
		window.onresize = =>
			@_resize()
		@_resize()
		# 
		$(window).bind "mousewheel", (e)=>
			@_scroll(e)

		# leftPaddle = new 
	start: ->
		console.log "start"
	stop: ->
		console.log "stop"
	tick: ->
		# Fade all elements
		@ctx.fillStyle = "rgba(255, 255, 255, 0.4)"
		@ctx.fillRect(0, 0, @canvas.width, @canvas.height)

		# Update positions
		time = new Date
		@gamePaddle.y = (1+Math.sin((time - startTime)*0.001))/2 * (@canvas.height-@gamePaddle.height)
		@ball.x = (1+Math.cos((time - startTime)*0.0005))/2 * @canvas.width
		@ball.y = @canvas.height / 2

		# Draw all elements
		@ctx.fillStyle = "rgb(0, 0, 0)"
		@ctx.fillRect(@gamePaddle.x, @gamePaddle.y, @gamePaddle.width, @gamePaddle.height)
		@ctx.fillStyle = @ballColor
		@ctx.fillRect(@ball.x, @ball.y, @ball.width, @ball.height)
		# Scroll bar
		@ctx.fillStyle = "#eeeeee"
		@ctx.fillRect(@canvas.width - SCROLL_WIDTH, 0, SCROLL_WIDTH, @canvas.height)
		@ctx.fillStyle = "#c0c0c0"
		@ctx.fillRect(@canvas.width - SCROLL_WIDTH, @scrollKnob.y, SCROLL_WIDTH, @scrollKnob.height)

	# Commandline interface
	setSpeed: (s)->
		s = 1 if s <= 0
		console.log "set speed to #{s}"
	setPaddleSize: (size)->
		# Save size
		@scrollKnob.height = 180
	# Private
	_resize: (e)->
		@canvas.width = window.innerWidth;
		@canvas.height = window.innerHeight;
	_scroll: (e)->
		# Check if we're starting the game
		if @onStart
			@onStart()
			@onStart = null

		@scrollKnob.y += e.originalEvent.wheelDelta
		# Keep in bounds
		@scrollKnob.y = KNOB_MARGIN_TOP if @scrollKnob.y < KNOB_MARGIN_TOP
		@scrollKnob.y = @canvas.height - KNOB_MARGIN_BOTTOM - @scrollKnob.height if @scrollKnob.y > @canvas.height - @scrollKnob.height - KNOB_MARGIN_BOTTOM
		e.preventDefault()

# Export
window.Pong = Pong


