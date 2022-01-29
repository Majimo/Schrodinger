extends YSort

func _physics_process(delta):
	EVENT.connect("is_alive", self, "_on_EVENT_is_alive")
		
func _on_EVENT_is_alive():
	if(GAME.get_is_alive()):
		print('vivant')
		$World_life_sound.pitch_scale = 1
	if(!GAME.get_is_alive()):
		print('mort')
		$World_life_sound.pitch_scale = 0.01
