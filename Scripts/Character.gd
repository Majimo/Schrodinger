extends KinematicBody2D

onready var cat = $"."
const GRAVITY = 1000
const JUMP = 500

var is_alive = true
var vel = Vector2()
var up = Vector2(0,-1)
export (int) var max_speed = 200


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_kill") && GAME.get_nb_hp() > 0:
		var gradient_death_effect = 25 if is_alive else -25
		var new_positionY = (-position.y) + gradient_death_effect
		up = Vector2(0,1) if is_alive else Vector2(0,-1)
		cat.set_position(Vector2(position.x, new_positionY))
		is_alive = !is_alive
		if !is_alive:
			EVENT.emit_signal("hp_lost")
		
	manage_gravity(delta)
	movement_loop()
	
	vel = move_and_slide(vel, up)


#### BUILT-IN ####

func movement_loop():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	
	var dirx = int(right) - int(left)
	vel.x = dirx * max_speed
	
	manage_animation(dirx != 0)
	
	manage_flip_h(dirx)

	if jump == true and is_on_floor():
		manage_jump()

func manage_gravity(delta):
	if is_alive:
		vel.y += GRAVITY * delta
	else:
		vel.y -= (GRAVITY/2) * delta
	
func manage_jump():
	if is_alive:
		vel.y = -JUMP
	else:
		vel.y = JUMP

func manage_animation(moving):
	$IdleAnimation.visible = !moving
	$Sprite.visible = moving
	
func manage_flip_h(dirx):
	if dirx == 1:
		$Sprite.flip_h = false
		$IdleAnimation.flip_h = false
	elif dirx == -1:
		$Sprite.flip_h = true
		$IdleAnimation.flip_h = true
