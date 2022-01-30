extends Area2D


## valeur par défaut de la gravité
const GRAVITY = 1000
var vel = Vector2()
var up = Vector2(0,-1)


func _ready():
	EVENT.connect("change_cat_bowl_sprite", self, "on_EVENT_change_cat_bowl_sprite")
	up = Vector2(0,1) if !GAME.get_is_alive() else Vector2(0,-1)

func _physics_process(delta):
	manage_gravity(delta)
	up = Vector2(0,1) if !GAME.get_is_alive() else Vector2(0,-1)


func on_EVENT_change_cat_bowl_sprite():
	var texture = load("res://Assets/Gamelle/pate_death.png")
	$Sprite.texture = texture

func manage_gravity(delta):
	if GAME.get_is_alive():
		vel.y += GRAVITY * delta
	else:
		vel.y -= (GRAVITY/2) * delta


func _on_cat_bowl_body_entered(body):
	get_tree().change_scene("res://Scenes/Victory.tscn") # Replace with function body.
