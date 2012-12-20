startTime = new Date

class Pong
	constructor: () ->
		
		# Get canvas
		@canvas = document.getElementById('game')
		@ctx = @canvas.getContext('2d')
		
		# Creating the left paddle (that the game controls)
		@gamePaddle = new createjs.Rectangle(20, 0, 30, 180)
		# Game's ball
		@ball = new createjs.Rectangle(20, 0, 30, 30)
		
		# Creating the scrollbar

		# Setup enter frame
		createjs.Ticker.addListener @
		# Setup resize listener
		window.onresize = @_resize
		@_resize()
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
		@gamePaddle.y = (1+Math.sin((time - startTime)*0.001))/2 * @canvas.height
		@ball.x = (1+Math.cos((time - startTime)*0.0005))/2 * @canvas.width
		@ball.y = @canvas.height / 2

		# Draw all elements
		@ctx.fillStyle = "rgb(0, 0, 0)"
		@ctx.fillRect(@gamePaddle.x, @gamePaddle.y, @gamePaddle.width, @gamePaddle.height)
		@ctx.fillStyle = "#1bc1ff"
		@ctx.fillRect(@ball.x, @ball.y, @ball.width, @ball.height)
		

	# Commandline interface
	setSpeed: (s)->
		s = 1 if s <= 0
		console.log "set speed to #{s}"
	setPaddleSize: (size)->
		# Save size
		@gamePaddle.height = 180
	
	# Private
	_resize: (e)->
		canvas = document.getElementById('game')
		canvas.width = window.innerWidth;
		canvas.height = window.innerHeight;


# Export
window.Pong = Pong


