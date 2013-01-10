class SoundPlayer
	queue: {}
	constructor: () ->

		@queue = new createjs.PreloadJS();
		@queue.installPlugin(createjs.SoundJS) #Plug in SoundJS to handle browser-specific paths
		
		# Load each sound
		for sound in ['click', 'hit_enemy', 'hit_me', 'lost', 'scroll_to_start', 'wall', 'hadouken']
			@queue.loadFile({src:"media/#{sound}.mp3|media/#{sound}.ogg", id: sound}, true)
		@queue.load
		
	play: (id)->
		createjs.SoundJS.play(id)

window.sound = new SoundPlayer()