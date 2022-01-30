extends KinematicBody2D

onready var cat = $"."

## valeur par défaut de la gravité
const GRAVITY = 1000
## valeur par défaut du saut
const JUMP = 500

var max_speed = 200

var is_alive = true
var vel = Vector2()
var up = Vector2(0,-1)

func _physics_process(delta):
	manage_gravity(delta)
	if GAME.get_can_move():
		if Input.is_action_just_pressed("ui_kill") && GAME.get_nb_hp() > 0:
			var gradient_death_effect = 25 if GAME.get_is_alive() else -25
			var new_positionY = position.y
			var new_positionX = position.x
			if is_on_floor():
				new_positionX += gradient_death_effect
			if is_on_wall():
				new_positionY -= gradient_death_effect
			new_positionY = (-position.y) + gradient_death_effect
			EVENT.emit_signal("is_alive")
			if !GAME.get_is_alive():
				EVENT.emit_signal("hp_lost")
			cat.set_position(Vector2(position.x, new_positionY))
		movement_loop()
	up = Vector2(0,1) if cat_is_in_dead_world() else Vector2(0,-1)
	vel = move_and_slide(vel, up)
	

#### BUILT-IN ####

func manage_animation(moving):
	if moving:
		$CatAnimation.play("walk")
		if !$CatWalk.is_playing():
			$CatWalk.play()
	else:
		$CatAnimation.play("idle")
		if $CatWalk.is_playing():
			$CatWalk.stop()

func manage_flip_h(dirx):
	if dirx == 1:
		$CatAnimation.flip_h = false
		$CollisionShape2D.position.x = POSITIONS.POS_X_RIGHT
	elif dirx == -1:
		$CatAnimation.flip_h = true
		$CollisionShape2D.position.x = POSITIONS.POS_X_LEFT

func manage_flip_v():
	$CatAnimation.flip_v = cat_is_in_dead_world()
	$CollisionShape2D.position.y = POSITIONS.POS_Y_UP if cat.position.y > 0 else POSITIONS.POS_Y_DOWN

func manage_gravity(delta):
	if cat_is_in_dead_world():
		vel.y -= (GRAVITY/2) * delta
	else:
		vel.y += GRAVITY * delta

func manage_jump():
	$CatAnimation.play("jump")
	if $CatWalk.is_playing():
		$CatWalk.stop()
	$CatJump.play()
	if GAME.get_is_alive():
		vel.y = -JUMP
	else:
		vel.y = JUMP

func movement_loop():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_pressed("ui_accept")
	
	var dirx = int(right) - int(left)
	vel.x = dirx * 200
	
	manage_flip_h(dirx)
	manage_flip_v()
	if is_on_floor():	
		manage_animation(dirx != 0)
		if jump == true:
			manage_jump()

func _on_CatAnimation_animation_finished():
	if "jump".is_subsequence_of($CatAnimation.get_animation()):
		$CatAnimation.stop()
		$CatAnimation.set_frame(3)

func cat_is_in_dead_world() -> bool:
	return cat.position.y > 0
