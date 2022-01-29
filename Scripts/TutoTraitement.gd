extends Control

var mvt_validated = false
var jump_validated = false
var transition_validated = false

func _ready():
	$AButton.visible = false
	$RT_button.visible = false
	$HUD_changer_monde.visible = false
	$HUD_saut.visible = false

	

func _physics_process(delta):	
	if(!mvt_validated && !jump_validated && !transition_validated):
		if(Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_left")):
			$Dpad.visible = false
			$HUD_deplacement.visible = false
			mvt_validated = true
			$AButton.visible = true
			$HUD_saut.visible = true

	if(mvt_validated && !jump_validated && !transition_validated):
		if(Input.is_action_pressed("ui_accept")):
			$AButton.visible = false
			$HUD_saut.visible = false
			jump_validated = true
			$RT_button.visible = true
			$HUD_changer_monde.visible = true
			
	if(mvt_validated && jump_validated && !transition_validated):
		if(Input.is_action_pressed("ui_kill")):
			$RT_button.visible = false
			$HUD_changer_monde.visible = false
			jump_validated = true
			
	
		
	
	
