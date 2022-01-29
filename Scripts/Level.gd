extends YSort

func _ready():
	EVENT.connect("is_alive", self, "_on_EVENT_is_alive")
	_on_EVENT_is_alive()


func _on_EVENT_is_alive():
	if(GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 1
		$World_death_sound.pitch_scale = 0.01
	if(!GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 0.01
		$World_death_sound.pitch_scale = 1
