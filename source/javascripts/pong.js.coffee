SCROLL_WIDTH = 18
KNOB_MARGIN_TOP = 18
KNOB_MARGIN_BOTTOM = 18
ANGLE_VARIATION = Math.PI / 4
TRAIL = 0.5

PADDLE_SPEED = 15

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
		@initialBallSpeed = 20
		# Create the scrollbar
		@scrollKnob = new createjs.Rectangle(0, KNOB_MARGIN_TOP, SCROLL_WIDTH, 250)
		@scrollUpRect = new createjs.Rectangle(0, 0, SCROLL_WIDTH, SCROLL_WIDTH)
		@scrollUpImage = new Image()
		@scrollUpImage.src = "images/scrollUp.jpg"
		@scrollDownRect = new createjs.Rectangle(0, 0, SCROLL_WIDTH, SCROLL_WIDTH)
		@scrollDownImage = new Image()
		@scrollDownImage.src = "images/scrollDown.jpg"

		# Setup 'update' timer
		createjs.Ticker.addListener @

		# Setup listeners
		window.onresize = =>
			@_resize()
		@_resize()
		# 
		$(window).bind "mousewheel", (e)=>
			@_scroll(e)
		$(@canvas).bind "mousedown", (e)=>
			@_mouseDown(e)
		$(@canvas).bind "mouseup", (e)=>
			@_mouseUp(e)

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
		
		# 
		# Update game logic
		# 
		@_updateGame() if @started

		# 
		# Fade all elements (trail)
		# 
		@ctx.fillStyle = "rgba(255, 255, 255, #{TRAIL})"
		@ctx.fillRect(0, 0, @canvas.width, @canvas.height)

		# 
		# Draw all elements
		# 
		@_draw()

	# Commandline interface
	setSpeed: (s)->
		@initialBallSpeed = s
	setPaddleSize: (size)->
		# Save size
		@scrollKnob.height = size
	
	# 
	# Private methods
	# 

	# Game logic
	_updateGame: ->

		# Check if it's time to follow the ball
		if @ball.x < @canvas.width/2
			# 
			# Move computer's paddle
			paddleMiddle = @gamePaddle.y + @gamePaddle.height/2
			paddleTh = @gamePaddle.height/2
			if paddleMiddle - paddleTh > @ball.y + @ball.height/2
				@gamePaddle.y -= PADDLE_SPEED
			else if paddleMiddle + paddleTh < @ball.y + @ball.height/2
				@gamePaddle.y += PADDLE_SPEED
			
			@gamePaddle.y = 0 if @gamePaddle.y < 0
			@gamePaddle.y = @canvas.height - @gamePaddle.height if @gamePaddle.y > @canvas.height - @gamePaddle.height
		

		# Calculate next ball position
		nextBall = @ball.clone()
		nextBall.x = @ball.x + @ball.speed * Math.cos(@ball.angle)
		nextBall.y = @ball.y + @ball.speed * Math.sin(@ball.angle)

		ballP1 = {X: @ball.x, Y: @ball.y + @ball.height/2}
		ballP2 = {X: nextBall.x, Y: nextBall.y + nextBall.height/2}

		# Paddle Collision
		if lineIntersectsLine(ballP1, ballP2, {X: @gamePaddle.x+@gamePaddle.width, Y: @gamePaddle.y}, {X: @gamePaddle.x+@gamePaddle.width, Y: @gamePaddle.y+@gamePaddle.height})
			a = @ball.height/2 + (@ball.y - @gamePaddle.y)
			a = (a / @gamePaddle.height)*2 - 1
			a = a * ANGLE_VARIATION
			@ball.angle = a
			return
		else if lineIntersectsLine(ballP1, ballP2, {X: @scrollKnob.x-@scrollKnob.width, Y: @scrollKnob.y}, {X: @scrollKnob.x-@scrollKnob.width, Y: @scrollKnob.y+@scrollKnob.height})
			a = @ball.height/2 + (@ball.y - @scrollKnob.y)
			a = (a / @scrollKnob.height)*2 - 1
			a = Math.PI - (a * ANGLE_VARIATION)
			@ball.angle = a
			return
		# Wall Collision
		else if nextBall.y < 0 || nextBall.y > @canvas.height - nextBall.height
			@ball.angle *= -1
			return
		else
			nextBall.angle = @ball.angle
			nextBall.speed = @ball.speed
			@ball = nextBall

		# 
		# 
		# Let's see now if someone scored
		# 
		# 
		# Computer missed, user scored
		if nextBall.x < 0
			@_setScore(@score + 1)
			@_newComputerRound()
		# User lost
		else if nextBall.x > @canvas.width - @ball.width
			@_newUserRound()

	# Draw the game
	_draw: ()->
		# Game paddle
		@ctx.fillStyle = "rgb(0, 0, 0)"
		@ctx.fillRect(@gamePaddle.x, @gamePaddle.y, @gamePaddle.width, @gamePaddle.height)
		# Ball
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

	# Updates score and it's interface
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
		@ball.x = @gamePaddle.x + @gamePaddle.width + 5
		@ball.y = @gamePaddle.y + Math.random()*@gamePaddle.height
		# Reset game speed
		@ball.speed = @initialBallSpeed
	# Listeners
	_resize: (e)->
		@canvas.width = window.innerWidth
		@canvas.height = window.innerHeight

		# Set elements positions (align)
		@scrollKnob.x = 
		@scrollUpRect.x =
		@scrollDownRect.x =
			@canvas.width - SCROLL_WIDTH
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
	_mouseDown: (e)->
		if @ball

# Export
window.Pong = Pong

# 
#  Helpers
# 
lineIntersectsLine = (l1p1, l1p2, l2p1, l2p2) ->
	q = (l1p1.Y - l2p1.Y) * (l2p2.X - l2p1.X) - (l1p1.X - l2p1.X) * (l2p2.Y - l2p1.Y)
	d = (l1p2.X - l1p1.X) * (l2p2.Y - l2p1.Y) - (l1p2.Y - l1p1.Y) * (l2p2.X - l2p1.X)

	if d == 0
		return false

	r = q / d
	q = (l1p1.Y - l2p1.Y) * (l1p2.X - l1p1.X) - (l1p1.X - l2p1.X) * (l1p2.Y - l1p1.Y);
	s = q / d;
	if( r < 0 || r > 1 || s < 0 || s > 1 )
		return false;

	return true;
createjs.Rectangle.prototype.containsPoint = (x, y)->
	(x >= @x && y >= @y && x <= @x + @width && y <= @y + @height)