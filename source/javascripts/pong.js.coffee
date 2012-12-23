ANGLE_VARIATION = Math.PI / 4
TRAIL = 0.5

PADDLE_SPEED = 8

class Pong
	ballColor: "#1bc1ff"
	constructor: () ->
		
		# Get canvas
		@canvas = document.getElementById('game')
		@ctx = @canvas.getContext('2d')
		
		# Creating the left paddle (that the game controls)
		@gamePaddle = new createjs.Rectangle(20, window.innerHeight/2 - 90, 30, 180)
		# Game's ball
		@ball = new createjs.Rectangle(20, 0, 30, 30)
		@initialBallSpeed = 15
		# Create the scrollbar
		if BrowserDetect.OS == "Win"
			@scroll = new WinScrollbar(@canvas)
		else
			@scroll = new Scrollbar(@canvas)


		# Setup framerate
		createjs.Ticker.setFPS(60)

		# Setup 'update' timer
		createjs.Ticker.addListener @

		# Setup listeners
		$(window).bind "resize", =>
			@_resize()
		@_resize()
		$(@scroll).bind 'knobmove', =>
			@_knobMove()

		# leftPaddle = new 
	start: ->
		# Reset scroll
		@scroll.reset()
		# Reset ball direction
		@ball.angle = 0

		@playAgain()
	playAgain: ()->
		# Reset score
		@_setScore(0)
		# Set ball position
		@ball.x = @canvas.width - @ball.width - @scroll.width - 5
		@ball.y = @scroll.knob.y + @scroll.knob.height/2
		# Reset game speed
		@ball.speed = @initialBallSpeed
		# stop wintil user scrolls
		@started = false
		# Show tooltip
		$("img.start").fadeIn()
		$(".score").fadeOut(0)
		# Hide hype animations
		$("#intro_hype_container").fadeOut(300)

		# Bind interaction events
		# 
		@scroll.enable()

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
		@ball.speed = @initialBallSpeed
	setPaddleSize: (size)->
		# Save size
		@scroll.knob.height = @gamePaddle.height = size

	# Hadouken special
	hadouken: ()->		
		$(".hadoukenImg").remove()
		for i in [0..5]
			$("body").append("<img src='images/hadouken.gif' class='hadoukenImg' style='position:absolute; left:#{-100 - Math.random()* 800}px; top:#{Math.random()*@canvas.height}px;'>")
		
		$(".hadoukenImg").animate {left:@canvas.width + 800},2000;

		interval = setInterval =>
			@ballColor = "rgb(#{Math.floor Math.random()*255}, #{Math.floor Math.random()*255}, #{Math.floor Math.random()*255})"
		, 50
		setTimeout -> 
			clearInterval(interval)
		, 3000
	# Private
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
		# Computer Paddle
		if lineIntersectsLine(ballP1, ballP2, {X: @gamePaddle.x+@gamePaddle.width, Y: @gamePaddle.y}, {X: @gamePaddle.x+@gamePaddle.width, Y: @gamePaddle.y+@gamePaddle.height})
			a = @ball.height/2 + (@ball.y - @gamePaddle.y)
			a = (a / @gamePaddle.height)*2 - 1
			a = a * ANGLE_VARIATION
			@ball.angle = a
			return
		# User Paddle
		else if lineIntersectsLine(ballP1, ballP2, {X: @scroll.knob.x-@scroll.knob.width, Y: @scroll.knob.y}, {X: @scroll.knob.x-@scroll.knob.width, Y: @scroll.knob.y+@scroll.knob.height})
			a = @ball.height/2 + (@ball.y - @scroll.knob.y)
			a = (a / @scroll.knob.height)*2 - 1
			a = Math.PI - (a * ANGLE_VARIATION)
			@ball.angle = a
			@ball.speed += 1
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
		else if nextBall.x > @canvas.width + @ball.width
			@_gameOver()

	# Draw the game
	_draw: ()->
		# Game paddle
		@ctx.fillStyle = "rgb(0, 0, 0)"
		@ctx.fillRect(@gamePaddle.x, @gamePaddle.y, @gamePaddle.width, @gamePaddle.height)
		# Ball
		@ctx.fillStyle = @ballColor
		@ctx.fillRect(@ball.x, @ball.y, @ball.width, @ball.height)
		# Scroll bar
		@scroll.draw()

	# Updates score and it's interface
	_setScore: (score)->
		@score = score
		$(".score .num").text(score)
	# Rounds
	_newComputerRound: ()->
		# Set ball position
		@ball.x = @gamePaddle.x + @gamePaddle.width + 5
		@ball.y = @gamePaddle.y + Math.random()*@gamePaddle.height
		# Reset game speed
		@ball.speed = @initialBallSpeed
	_gameOver: ()->
		return if not @started
		@started = false

		# Unbind interaction
		@scroll.disable()

		# Show animation
		$("#intro_hype_container").show()
		doc = HYPE.documents["intro"]
		doc.showSceneNamed("game over")
		score = doc.getElementById('animScore')
		$(score).html("<span class='animScore'>#{@score}<span class='pts'>PTS</span></span>")
		# Set score
	# Listeners
	_resize: (e)->
		@canvas.width = window.innerWidth
		@canvas.height = window.innerHeight
		@scroll.resize()
	_knobMove: ()->
		# Check if we're starting the game
		if not @started
			# Show tooltip
			$("img.start").fadeOut(300)
			$(".score").delay(300).fadeIn()
			@started = true

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
