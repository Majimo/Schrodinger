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
		toggle_flip_v()
	manage_gravity(delta)
	movement_loop()
	
	vel = move_and_slide(vel, up)


#### BUILT-IN ####

## permet de switcher les sprites visibles selon le type de mouvement
func manage_animation(moving):
	$IdleAnimation.visible = !moving
	$Sprite.visible = moving

## permet de gérer la direction horizontale 
## dans laquelle le personnage est affiché
func manage_flip_h(dirx):
	if dirx == 1:
		$Sprite.flip_h = false
		$IdleAnimation.flip_h = false
		$CollisionShape2D.position.x = POSITION.POS_X_RIGHT
	elif dirx == -1:
		$Sprite.flip_h = true
		$IdleAnimation.flip_h = true
		$CollisionShape2D.position.x = POSITION.POS_X_LEFT

## gère la gravité selon que le personnage est vivant ou mort
## vers le bas pour le monde des vivants et vers le haut pour le monde des morts
func manage_gravity(delta):
	if GAME.get_is_alive():
		vel.y += GRAVITY * delta
	else:
		vel.y -= (GRAVITY/2) * delta

## fait sauter le chat dans bon sens selon le monde dans lequel il se trouve
func manage_jump():
	if GAME.get_is_alive():
		vel.y = -JUMP
	else:
		vel.y = JUMP

## récupère les actions utilisateurs pour gérer les mouvements du personnage
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

## permet de gérer la position verticale
## dans laquelle le personnage est affiché
func toggle_flip_v():
	$Sprite.flip_v = !GAME.get_is_alive()
	$IdleAnimation.flip_v = !GAME.get_is_alive()
	$IdleAnimation.set_modulate(COLORS.cat_alive if GAME.get_is_alive() else COLORS.cat_dead)
	$CollisionShape2D.position.y = POSITION.POS_Y_UP if GAME.get_is_alive() else POSITION.POS_Y_DOWN
