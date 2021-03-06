extends VBoxContainer

onready var hp_counter_label = $HP/HPCounter

func _ready():
	hp_counter_label.set_text(String(GAME.get_nb_hp()))
	EVENT.connect("nb_hp_changed", self, "on_EVENT_nb_hp_changed")


func on_EVENT_nb_hp_changed(nb_hp: int):
	hp_counter_label.set_text(" " + String(nb_hp))
