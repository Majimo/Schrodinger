extends Node

var nb_hp: int = 9 setget set_nb_hp, get_nb_hp
var is_alive: bool = true setget set_is_alive, get_is_alive


#### ACCESSORS ####
func set_nb_hp(value: int):
	if value != nb_hp:
		nb_hp = value
		EVENT.emit_signal("nb_hp_changed", nb_hp)

func get_nb_hp() -> int:
	return nb_hp

func set_is_alive(value: bool):
	if value != is_alive:
		is_alive = value
		EVENT.emit_signal("is_alive_changed", is_alive)

func get_is_alive() -> bool:
	return is_alive 
	
func _ready():
	EVENT.connect("hp_lost", self, "_on_EVENT_hp_lost")
	EVENT.connect("is_alive", self, "_on_EVENT_is_alive")
	EVENT.connect("set_hp_based_on_difficulty", self, "_on_EVENT_set_hp_based_on_difficulty")


func _on_EVENT_hp_lost():
	set_nb_hp(nb_hp - 1)

func _on_EVENT_is_alive():
	set_is_alive(!is_alive)

func _on_EVENT_set_hp_based_on_difficulty(difficulty: int):
	if difficulty == 0:
		set_nb_hp(9)
	else:
		set_nb_hp(7)
