extends Node2D

onready var difficulty_state = $CanvasLayer/Control/DifficultyState
var difficulty = 0

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_kill"):
		if difficulty == 0:
			difficulty = 1
			EVENT.emit_signal("set_hp_based_on_difficulty", difficulty)
			difficulty_state.set_text("Difficile")
		else:
			difficulty = 0
			EVENT.emit_signal("set_hp_based_on_difficulty", difficulty)
			difficulty_state.set_text("Facile")
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/Level1.tscn")
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Scenes/Tuto.tscn")


func _on_VideoPlayer_finished():
	$CanvasLayer/Control/VideoPlayer.play()
