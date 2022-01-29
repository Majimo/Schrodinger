extends YSort

# Position initial Caracter 
var Caracter_PosX = 200
var Caracter_PosY = 200

# Position initial Cat_bowl
var Cat_bowl_PosX = 1600
var Cat_bowl_PosY = 600

func _ready():
	
	
	EVENT.connect("is_alive", self, "_on_EVENT_is_alive")
	_on_EVENT_is_alive()
	_set_position_player()
	_set_position_cat_bowl()
	print($Cat_bowl.position)
	print($Character.position)


func _on_EVENT_is_alive():
	if(GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 1
		$World_death_sound.pitch_scale = 0.01
	if(!GAME.get_is_alive()):
		$World_life_sound.pitch_scale = 0.01
		$World_death_sound.pitch_scale = 1
		
func _set_position_player():
	randomize()
	var posistionAleatoire = Vector2()
	var aleatoire = 2
#	var aleatoire = randi() % 100
	print(aleatoire)
	print(aleatoire%2)
	if(aleatoire % 2 == 0 ):
		Caracter_PosY = -Caracter_PosY
		GAME.set_is_alive(false)
	posistionAleatoire.x = Caracter_PosX
	posistionAleatoire.y = -Caracter_PosY
	print(posistionAleatoire)
	$Character.position = posistionAleatoire
	
func _set_position_cat_bowl():
	randomize()
	var posistionAleatoire = Vector2()
	var aleatoire = randi() % 100
	print(aleatoire)
	print(aleatoire%2)
	if(aleatoire % 2 == 0 ):
		Cat_bowl_PosY = -Cat_bowl_PosY
	posistionAleatoire.x = Cat_bowl_PosX
	posistionAleatoire.y = -Cat_bowl_PosY
	print(posistionAleatoire)
	$Cat_bowl.position = posistionAleatoire
	
