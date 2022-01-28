extends KinematicBody2D

var speed = 300.0
var direction = Vector2.ZERO

func _process(delta):
	move_and_slide(direction * speed)

func _input(_event):
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	direction = direction.normalized()
	
	#Pour simulation des pertes de PV
	if Input.is_action_pressed("ui_accept"):
		EVENT.emit_signal("hp_lost")
