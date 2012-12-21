class Terminal
  constructor: (@gameInstance) ->
    #Prevent errors and warning from outputing on console
    #window.onerror = () -> true

    if (console._commandLineAPI?)
      window.clear = console._commandLineAPI.clear
    else if (console._inspectorCommandLineAPI?)
      window.clear = console._inspectorCommandLineAPI.clear
    else if (_FirebugCommandLine?)
      window.clear = _FirebugCommandLine.clear
    else
      window.clear = ()-> console.log("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")

    setInterval =>
      @checkVariables()
    ,500

    setTimeout  =>
        @printMenu()
    , 1000

  checkVariables: () ->
    if(window.ballSpeed)
      @printMessage("Você setou a velocidade para #{window.ballSpeed}")
      @gameInstance.setSpeed(window.ballSpeed)
      window.ballSpeed = null #sets the global variable to null so we can keep checking it
      setTimeout  =>
        @printMenu()
      , 1000
      
    if(window.ballColor)
      @printMessage("Você setou a cor para #{window.ballColor}")
      @gameInstance.ballColor = window.ballColor
      window.ballColor = null
      setTimeout  =>
        @printMenu()
      , 1000
    if(window.paddleSize)
      @printMessage("Você setou o tamanho do paddle para #{window.paddleSize}")
      @gameInstance.setPaddleSize(window.paddleSize)
      window.paddleSize = null
      setTimeout  =>
        @printMenu()
      , 1000

  printMessage: (str) ->
    window.clear()
    output = "┏██████████████████████████████████████████████████████████████┓\n
┃                                                              ┃\n┃"
    spaces = 56 - str.length
    output += " " for x in [0..spaces/2]
    output += "[ #{str} ]"
    output += " " for x in [0..spaces/2+spaces%2]
    output += "┃\n
┃                                                              ┃\n
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"
    console.log output

  printMenu: () ->
    console.log "┏██████████████████████████████████████████████████████████████┓\n
┃                                                              ┃\n
┃              [ PONG DEVELOPERS TERMINAL ACCESS ]             ┃\n
┃                                                              ┃\n
┃                   TYPE COMMAND TO EXECUTE:                   ┃\n
┃                                                              ┃\n
┃                                                              ┃\n
┃     ‣ ballSpeed = number                                     ┃\n
┃           (changes the ball speed, defaults to 20)           ┃\n
┃     ‣ ballColor = string                                     ┃\n
┃           (changes the ball color, defaults to \"#1bc1ff\")    ┃\n
┃     ‣ paddleSize = number                                    ┃\n
┃           (changes the player's paddle size)                 ┃\n
┃     ‣ haduken()                                              ┃\n
┃           (Why don't you try it out?)                        ┃\n
┃                                                              ┃\n
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛"

window.Terminal = Terminal