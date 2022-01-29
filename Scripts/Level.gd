extends YSort

# Position initial Caracter 
export var Caracter_PosX = 200
export var Caracter_PosY = 200

# Position initial Cat_bowl
export var Cat_bowl_PosX_Alive = 1600
export var Cat_bowl_PosY_Alive = -600

export var Cat_bowl_PosX_Dead = 1600
export var Cat_bowl_PosY_Dead = 600

var is_dialog_finished = false


func _ready():
	if !GAME.get_can_move():
		var new_dialog = Dialogic.start("intro")
		add_child(new_dialog)
		new_dialog.connect("dialogic_signal", self, "_on_dialog_listener")
		$Character.visible = false

	EVENT.connect("is_alive", self, "_on_EVENT_is_alive")
	_set_position_player()
	_on_EVENT_is_alive()
	_set_position_cat_bowl()

func _physics_process(delta):
	if (is_dialog_finished and Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://Scenes/Intro.tscn")

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
	var random = randi() % 100
	var is_in_dead_world = random % 2 == 0
	var randomPosition = Vector2(
		Cat_bowl_PosX_Dead if is_in_dead_world else Cat_bowl_PosX_Alive,
		Cat_bowl_PosY_Dead if is_in_dead_world else Cat_bowl_PosY_Alive
	)
	if(is_in_dead_world):
		$Cat_bowl.set_rotation(deg2rad(180))
		EVENT.emit_signal("change_cat_bowl_sprite")
	$Cat_bowl.position = randomPosition

#### SIGNALS ####

func _on_dialog_listener(string: String):
	match string:
		"end_intro":
			var t = Timer.new()
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			is_dialog_finished = true
			$Character.visible = true
			EVENT.emit_signal("can_move")

func _on_EVENT_is_alive():
	if(GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 1
		$World_death_sound.pitch_scale = 0.01
	if(!GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 0.01
		$World_death_sound.pitch_scale = 1
