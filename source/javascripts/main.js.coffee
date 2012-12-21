game = new Pong();

game.start()

# game.setSpeed()
# game.setPaddleSize(190)

terminal = new Terminal(game)
window.hadouken = terminal.hadouken
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
