class SoundPlayer
	sounds: {}
	constructor: () ->

		# Load each sound
		for sound in ['click', 'hit_enemy', 'hit_me', 'lost', 'scroll_to_start', 'wall']
			@sounds[sound] = new Audio()
			@sounds[sound].src = "sounds/#{sound}.mp3"
			@sounds[sound].load()
		
	play: (id)->
		@sounds[id].play()

window.sound = new SoundPlayer()