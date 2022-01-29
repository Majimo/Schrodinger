extends Node2D

func _ready():
	EVENT.connect("change_cat_bowl_sprite", self, "on_EVENT_change_cat_bowl_sprite")

func _on_cat_bowl_body_entered(body):
	get_tree().change_scene("res://Scenes/Victory.tscn")
	queue_free()

func on_EVENT_change_cat_bowl_sprite():
	var texture = load("res://Assets/Gamelle/pate_death.png")
	$Sprite.texture = texture
