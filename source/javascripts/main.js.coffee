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
	window.hadouken = ()->
		terminal.hadouken()
		game.hadouken()

$("header").fadeOut(0)

# Credtis animation
setInterval ->
	$(".credits").attr('src', $(".credits").attr('src'))
, 5000

window.fbShare = () ->
  obj = {
    method: 'feed',
    redirect_uri: 'http://pongscroll.me',
    link: 'http://pongscroll.me',
    name: 'PongScroll',
    caption: 'Lets pong your scroll',
    description: "I've ponged my scroll"
  }

  callback = (response)->
    console.log "Thanks for sharing"
  
  FB.ui(obj, callback)
  sound.play('click')

