extends Node2D



func _on_cat_bowl_body_entered(body):
	get_tree().change_scene("res://Scenes/Victory.tscn")
	queue_free()

