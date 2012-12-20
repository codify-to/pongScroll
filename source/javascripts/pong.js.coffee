SCROLL_WIDTH = 18
KNOB_MARGIN_TOP = 18
KNOB_MARGIN_BOTTOM = 18

class Pong
	ballColor: "#1bc1ff"
	constructor: () ->
		
		# Get canvas
		@canvas = document.getElementById('game')
		@ctx = @canvas.getContext('2d')
		
		# Creating the left paddle (that the game controls)
		@gamePaddle = new createjs.Rectangle(20, 0, 30, 180)
		# Game's ball
		@ball = new createjs.Rectangle(20, 0, 30, 30)
		@initialBallSpeed = 0.5
		# Create scrollbar
		@scrollKnob = new createjs.Rectangle(0, KNOB_MARGIN_TOP, SCROLL_WIDTH, 250)
		@scrollUpImage = new Image()
		@scrollUpImage.src = "images/scrollUp.jpg"
		@scrollDownImage = new Image()
		@scrollDownImage.src = "images/scrollDown.jpg"
		
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
		@started = false
		# Show tooltip
		$("img.start").fadeIn()
		$(".score").fadeOut()
		# Reset scroll
		@scrollKnob.y = KNOB_MARGIN_TOP
		# Reset ball position and direction
		@ball.x = @canvas.width - @ball.width - SCROLL_WIDTH - 5
		@ball.y = @scrollKnob.y + @scrollKnob.height/2
		@ball.angle = 0
		@ball.speed = @initialBallSpeed
	stop: ->
		console.log "stop"
	tick: ->
		# Fade all elements
		@ctx.fillStyle = "rgba(255, 255, 255, 0.4)"
		@ctx.fillRect(0, 0, @canvas.width, @canvas.height)

		# Update positions if we're playing
		@_updateGame() if @started

		# Draw all elements
		@ctx.fillStyle = "rgb(0, 0, 0)"
		@ctx.fillRect(@gamePaddle.x, @gamePaddle.y, @gamePaddle.width, @gamePaddle.height)
		@ctx.fillStyle = @ballColor
		@ctx.fillRect(@ball.x, @ball.y, @ball.width, @ball.height)
		# Scroll bar
		@ctx.fillStyle = "#eeeeee"
		@ctx.fillRect(@canvas.width - SCROLL_WIDTH, 0, SCROLL_WIDTH, @canvas.height)
		@ctx.fillStyle = "#c0c0c0"
		@ctx.fillRect(@canvas.width - SCROLL_WIDTH + 2, @scrollKnob.y + 2, SCROLL_WIDTH - 2, @scrollKnob.height)
		@ctx.lineWidth = 1
		@ctx.strokeStyle = "#808080"
		@ctx.strokeRect(@canvas.width - SCROLL_WIDTH + 0.5, @scrollKnob.y + 0.5, SCROLL_WIDTH - 1, @scrollKnob.height)
		# Top and bottom buttons
		@ctx.drawImage(@scrollUpImage, @canvas.width - SCROLL_WIDTH, 0)
		@ctx.drawImage(@scrollDownImage, @canvas.width - SCROLL_WIDTH, @canvas.height - KNOB_MARGIN_BOTTOM)

	# Commandline interface
	setSpeed: (s)->
		@initialBallSpeed = s
	setPaddleSize: (size)->
		# Save size
		@scrollKnob.height = size
	# Private
	_updateGame: ->
		@ball.x += @ball.speed * Math.cos(@ball.angle)
		@ball.y += @ball.speed * Math.sin(@ball.angle)
		# @gamePaddle.y = (1+Math.sin((time - startTime)*0.001))/2 * (@canvas.height-@gamePaddle.height)
		# @ball.x = (1+Math.cos((time - startTime)*0.0005))/2 * @canvas.width
		# @ball.y = @canvas.height / 2

	_resize: (e)->
		@canvas.width = window.innerWidth;
		@canvas.height = window.innerHeight;
	_scroll: (e)->
		# Check if we're starting the game
		if not @started
			# Show tooltip
			$("img.start").fadeOut(300)
			$(".score").delay(300).fadeIn()
			@started = true

		@scrollKnob.y += e.originalEvent.wheelDelta
		# Keep in bounds
		@scrollKnob.y = KNOB_MARGIN_TOP if @scrollKnob.y < KNOB_MARGIN_TOP
		@scrollKnob.y = @canvas.height - KNOB_MARGIN_BOTTOM - @scrollKnob.height if @scrollKnob.y > @canvas.height - @scrollKnob.height - KNOB_MARGIN_BOTTOM
		e.preventDefault()

# Export
window.Pong = Pong


