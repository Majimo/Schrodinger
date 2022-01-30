extends CanvasLayer

var available_levels: Array = [1, 2, 3]
var selected_level = 1

onready var level1 = $Control/Level1
onready var level2 = $Control/Level2
onready var level3 = $Control/Level3


func _ready():
	level1.set("custom_colors/font_color", Color(COLORS.darkorange))
	level2.set("custom_colors/font_color", Color(COLORS.darkorange))
	level3.set("custom_colors/font_color", Color(COLORS.darkorange))
	level1.get("custom_fonts/font").set_outline_size(4)
	level1.get("custom_fonts/font").set_outline_color(Color(COLORS.lightorange))

func _physics_process(delta):
	if(Input.is_action_just_pressed("ui_accept")):
		get_tree().change_scene("res://Scenes/Level" + String(selected_level) + ".tscn")

	if(Input.is_action_just_pressed("ui_right")) && selected_level < 3:
		selected_level = available_levels[selected_level]
		select_level_from_list()
	if(Input.is_action_just_pressed("ui_left")) && selected_level > 1:
		selected_level = available_levels[selected_level - 2]
		select_level_from_list()


func select_level_from_list():
	level1.get("custom_fonts/font").set_outline_size(0)
	level2.get("custom_fonts/font").set_outline_size(0)
	level3.get("custom_fonts/font").set_outline_size(0)
	level1.set("custom_colors/font_color", Color(COLORS.darkorange))
	level2.set("custom_colors/font_color", Color(COLORS.darkorange))
	level3.set("custom_colors/font_color", Color(COLORS.darkorange))
	match_selected_level(selected_level)

func match_selected_level(selected_level: int):
	match selected_level:
		1:
			level1.set("custom_colors/font_color", Color(COLORS.darkorange))
			level1.get("custom_fonts/font").set_outline_size(4)
			level1.get("custom_fonts/font").set_outline_color(Color(COLORS.lightorange))
		2:
			level2.set("custom_colors/font_color", Color(COLORS.darkorange))
			level2.get("custom_fonts/font").set_outline_size(4)
			level2.get("custom_fonts/font").set_outline_color(Color(COLORS.lightorange))
		3:
			level3.set("custom_colors/font_color", Color(COLORS.darkorange))
			level3.get("custom_fonts/font").set_outline_size(4)
			level3.get("custom_fonts/font").set_outline_color(Color(COLORS.lightorange))
