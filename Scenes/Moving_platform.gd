extends RigidBody2D

export (int) var duration = 3
export var distance = Vector2(150,150)

func _ready():
	move()

func move():
	$Tween.interpolate_property(
		self, 
		"position", 
		global_position,
		global_position + distance,
		duration,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT
		)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	distance *= -1
	move()
