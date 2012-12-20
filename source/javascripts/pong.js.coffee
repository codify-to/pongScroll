SCROLL_WIDTH = 18
KNOB_MARGIN_TOP = 18
KNOB_MARGIN_BOTTOM = 18
ANGLE_VARIATION = Math.PI / 4

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
		@initialBallSpeed = 15
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
		# Reset score
		@_setScore(0)
		# Reset scroll
		@scrollKnob.y = KNOB_MARGIN_TOP
		# Reset ball direction
		@ball.angle = 0

		@_newUserRound()
		
	stop: ->
		@started = false
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
		@ctx.fillRect(@scrollKnob.x, 0, @scrollKnob.width, @canvas.height)
		@ctx.fillStyle = "#c0c0c0"
		@ctx.fillRect(@scrollKnob.x + 2, @scrollKnob.y + 2, @scrollKnob.width - 2, @scrollKnob.height)
		@ctx.lineWidth = 1
		@ctx.strokeStyle = "#808080"
		@ctx.strokeRect(@scrollKnob.x + 0.5, @scrollKnob.y + 0.5, @scrollKnob.width - 1, @scrollKnob.height)
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
		# Calculate next ball position
		nextBall = @ball.clone()
		nextBall.x = @ball.x + @ball.speed * Math.cos(@ball.angle)
		nextBall.y = @ball.y + @ball.speed * Math.sin(@ball.angle)

		# 
		# Check what to do!
		# 

		# Computer missed, user scored
		if nextBall.x < 0
			@_setScore(@score + 1)
			@_newComputerRound()
			return
		# User lost
		else if nextBall.x > @canvas.width - @ball.width
			@_newUserRound()
			return

		# Paddle Collision
		if nextBall.overlapsRect(@gamePaddle)
			a = @ball.height/2 + (@ball.y - @gamePaddle.y)
			a = (a / @gamePaddle.height)*2 - 1
			a = a * ANGLE_VARIATION
			@ball.angle = a
		else if nextBall.overlapsRect(@scrollKnob)
			a = @ball.height/2 + (@ball.y - @scrollKnob.y)
			a = (a / @scrollKnob.height)*2 - 1
			a = Math.PI - (a * ANGLE_VARIATION)
			@ball.angle = a
		# Wall Collision
		else if nextBall.y < 0 || nextBall.y > @canvas.height - nextBall.height
			@ball.angle *= -1 #Math.PI - @ball.angle
		else
			nextBall.angle = @ball.angle
			nextBall.speed = @ball.speed
			@ball = nextBall
	_setScore: (score)->
		@score = score
		$(".score .num").text(score)
	# Rounds
	_newUserRound: ()->
		# Set ball position
		@ball.x = @canvas.width - @ball.width - SCROLL_WIDTH - 5
		@ball.y = @scrollKnob.y + @scrollKnob.height/2
		# Reset game speed
		@ball.speed = @initialBallSpeed
		# stop wintil user scrolls
		@started = false
		# Show tooltip
		$("img.start").fadeIn()
		$(".score").fadeOut()
	_newComputerRound: ()->
		# Set ball position
		@ball.x = @gamePaddle.x + SCROLL_WIDTH + 5
		@ball.y = @gamePaddle.y + Math.random()*@gamePaddle.height
		# Reset game speed
		@ball.speed = @initialBallSpeed
	# Listeners
	_resize: (e)->
		@canvas.width = window.innerWidth
		@canvas.height = window.innerHeight
		@scrollKnob.x = @canvas.width - SCROLL_WIDTH
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

createjs.Rectangle.prototype.overlapsRect = (r)->
	# http://stackoverflow.com/questions/306316/determine-if-two-rectangles-overlap-each-other =)
	(@x < r.x + r.width && @x + @width > r.x && @y < r.y + r.height && @y + @height > r.y)
