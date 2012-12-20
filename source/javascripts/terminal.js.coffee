class Terminal
  constructor: () ->
    #Prevent errors and warning from outputing on console
    #window.onerror = () -> true
    setInterval(@.checkVariables,500)

  checkVariables: () ->
    if(window.ballSpeed)
      console.log("Setou a velocidade!")
      window.ballSpeed = null
    if(window.ballColor)
      console.log("Setou a cor!")
      window.ballColor = null
    if(window.paddleSize)
      console.log("Setou o paddle!")
      window.paddleSize = null

  printMessage: (str) ->
    # todo

    

  printMenu: () ->
    console.log "┏████████████████████████████████████████████████████████████████████┓\n
┃                                                                    ┃\n
┃                 [ PONG DEVELOPERS TERMINAL ACCESS ]                ┃\n
┃                                                                    ┃\n
┃                      TYPE COMMAND TO EXECUTE:                      ┃\n
┃                                                                    ┃\n
┃                                                                    ┃\n
┃         ‣ ballSpeed = number                                       ┃\n
┃               (changes the ball speed, varies between 0-1,         ┃\n
┃                defaults to 0.5)                                    ┃\n
┃         ‣ ballColor = string                                       ┃\n
┃               (changes the ball color, defaults to \"#1bc1ff\")      ┃\n
┃         ‣ paddleSize = number                                      ┃\n
┃               (changes the player's paddle size)                   ┃\n
┃         ‣ haduken()                                                ┃\n
┃               (Why don't you try it out?)                          ┃\n
┃                                                                    ┃\n
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"

window.Terminal = Terminal