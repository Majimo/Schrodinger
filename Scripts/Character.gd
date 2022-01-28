extends KinematicBody2D

const GRAVITY = 1000
const UP = Vector2(0,-1)
const JUMP = 500

var is_alive = true
var vel = Vector2()
export (int) var max_speed = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_kill"):
		is_alive = !is_alive
		
	manage_gravity(delta)
	movement_loop()
	
	vel = move_and_slide(vel, UP)

func movement_loop():
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_accept")
	
	var dirx = int(right) - int(left)
	vel.x = dirx * max_speed
	
	if dirx == -1:
		$Sprite.flip_h = true
	elif dirx == 1:
		$Sprite.flip_h = false

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
