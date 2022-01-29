extends YSort

func _ready():
	var new_dialog = Dialogic.start("intro")
	add_child(new_dialog)
	new_dialog.connect("dialogic_signal", self, "dialog_listener")

	EVENT.connect("is_alive", self, "_on_EVENT_is_alive")
	_on_EVENT_is_alive()


func dialog_listener(string: String):
	match string:
		"end_intro":
			print("wouhou")

func _on_EVENT_is_alive():
	if(GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 1
	if(!GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 0.01
