class Terminal
  constructor: () ->
    

  printMenu: () ->
    console.log "┏████████████████████████████████████████████████████████████████████┓\n
┃                                                                    ┃\n
┃                           [ MAIN MENU ]                            ┃\n
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