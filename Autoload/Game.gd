extends Node

var nb_hp: int = 10 setget set_nb_hp, get_nb_hp

#### ACCESSORS ####
func set_nb_hp(value: int):
	if value != nb_hp:
		nb_hp = value
		EVENT.emit_signal("nb_hp_changed", nb_hp)

func get_nb_hp() -> int:
	return nb_hp

func _ready():
	EVENT.connect("hp_lost", self, "_on_EVENT_hp_lost")
	

func _on_EVENT_hp_lost():
	set_nb_hp(nb_hp - 1)
