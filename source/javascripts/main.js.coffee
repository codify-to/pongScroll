window.initGame = ->
	# Remove intro animation
	$("#intro_hype_container").hide();

	$("header").fadeIn(500)

	# Create the game
	game = new Pong();
	game.start()
	window.game = game

	# Create console
	terminal = new Terminal(game)
	window.hadouken = terminal.hadouken

$("header").fadeOut(0)

# Credtis animation
setInterval ->
	$(".credits").attr('src', $(".credits").attr('src'))
, 5000