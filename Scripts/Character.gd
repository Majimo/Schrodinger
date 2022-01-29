extends KinematicBody2D

onready var cat = $"."

## valeur par défaut de la gravité
const GRAVITY = 1000
## valeur par défaut du saut
const JUMP = 500

export (int) var max_speed = 200

var is_alive = true
var vel = Vector2()
var up = Vector2(0,-1)

func _ready():
	up = Vector2(0,1) if GAME.get_is_alive() else Vector2(0,-1)
## fonction fournie par défaut pour réaliser des actions 60*/secondes
func _physics_process(delta):
	

	if Input.is_action_just_pressed("ui_kill") && GAME.get_nb_hp() > 0:
		var gradient_death_effect = 25 if GAME.get_is_alive() else -25
		var new_positionY = position.y
		var new_positionX = position.x
		if is_on_floor():
			new_positionX+= gradient_death_effect
		if is_on_wall():
			new_positionY-= gradient_death_effect
		new_positionY = (-position.y) + gradient_death_effect
		up = Vector2(0,1) if GAME.get_is_alive() else Vector2(0,-1)
		EVENT.emit_signal("is_alive")
		if !GAME.get_is_alive():
			EVENT.emit_signal("hp_lost")
		cat.set_position(Vector2(position.x, new_positionY))
	manage_gravity(delta)
	movement_loop()
	
	vel = move_and_slide(vel, up)


#### BUILT-IN ####

func manage_animation(moving):
	$IdleAnimation.visible = !moving
	$Sprite.visible = moving

func manage_flip_h(dirx):
	if dirx == 1:
		$Sprite.flip_h = false
		$IdleAnimation.flip_h = false
		$CollisionShape2D.position.x = 8
	elif dirx == -1:
		$Sprite.flip_h = true
		$IdleAnimation.flip_h = true
		$CollisionShape2D.position.x = -7

func manage_flip_v():
	$Sprite.flip_v = !GAME.get_is_alive()
	$IdleAnimation.flip_v = !GAME.get_is_alive()
	$CollisionShape2D.position.y = 8 if GAME.get_is_alive() else -2

func manage_gravity(delta):
	if GAME.get_is_alive():
		vel.y += GRAVITY * delta
	else:
		vel.y -= (GRAVITY/2) * delta

func manage_jump():
	if GAME.get_is_alive():
		vel.y = -JUMP
		print('is_alive jump')
	else:
		vel.y = JUMP
		print('dead jump')


func movement_loop():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	
	var dirx = int(right) - int(left)
	vel.x = dirx * max_speed
	
	manage_animation(dirx != 0)
	
	manage_flip_h(dirx)
	manage_flip_v()
	print(is_on_floor())
	print(jump)
	if jump == true and is_on_floor():
		manage_jump()
