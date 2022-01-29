extends YSort

# Position initial Caracter 
var Caracter_PosX = 200
var Caracter_PosY = 200

# Position initial Cat_bowl
export var Cat_bowl_PosX = 1600
export var Cat_bowl_PosY = 600

func _ready():
	var new_dialog = Dialogic.start("intro")
	add_child(new_dialog)
	new_dialog.connect("dialogic_signal", self, "_on_dialog_listener")

	EVENT.connect("is_alive", self, "_on_EVENT_is_alive")
	_set_position_player()
	_on_EVENT_is_alive()
	_set_position_cat_bowl()


func _set_position_player():
	randomize()
	var posistionAleatoire = Vector2()
	var aleatoire = randi() % 100
	if(aleatoire % 2 == 0 ):
		Caracter_PosY = -Caracter_PosY
		GAME.set_is_alive(false)
	posistionAleatoire.x = Caracter_PosX
	posistionAleatoire.y = -Caracter_PosY
	$Character.position = posistionAleatoire
	
func _set_position_cat_bowl():
	randomize()
	var posistionAleatoire = Vector2()
	var aleatoire = randi() % 100
	var is_in_dead_world = aleatoire % 2 == 0
	posistionAleatoire.y = -Cat_bowl_PosY
	if(is_in_dead_world):
		posistionAleatoire.y = Cat_bowl_PosY
		$Cat_bowl.set_rotation(deg2rad(180))
		EVENT.emit_signal("change_cat_bowl_sprite")
	posistionAleatoire.x = Cat_bowl_PosX
	$Cat_bowl.position = posistionAleatoire

#### SIGNALS ####

func _on_dialog_listener(string: String):
	match string:
		"end_intro":
			print("on démarre, à voir ce qu'on en fait")

func _on_EVENT_is_alive():
	if(GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 1
		$World_death_sound.pitch_scale = 0.01
	if(!GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 0.01
		$World_death_sound.pitch_scale = 1
