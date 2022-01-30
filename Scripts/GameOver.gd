extends Node2D

func _ready():
	EVENT.emit_signal("is_alive")
	EVENT.emit_signal("set_hp_based_on_difficulty", 0)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Level1.tscn")
