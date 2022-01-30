extends Control

var mvt_left_validated = false
var mvt_right_validated = false
var jump_validated = false
var transition_validated = false

func _ready():
	$AButton.visible = false
	$RT_button.visible = false
	$HUD_changer_monde.visible = false
	$HUD_saut.visible = false
	$GoForGamelle.visible = false

func _physics_process(delta):	
	if (!mvt_left_validated || !mvt_right_validated) && !jump_validated && !transition_validated:
		if Input.is_action_pressed("ui_right"):
			$Dpad2.visible = false
			mvt_right_validated = true
		if Input.is_action_pressed("ui_left"):
			$Dpad.visible = false
			mvt_left_validated = true

	if(mvt_left_validated && mvt_right_validated && !jump_validated && !transition_validated):
		$HUD_deplacement.visible = false
		$AButton.visible = true
		$HUD_saut.visible = true
		if(Input.is_action_pressed("ui_accept")):
			$AButton.visible = false
			$HUD_saut.visible = false
			jump_validated = true
			
	if(mvt_left_validated && mvt_right_validated && jump_validated && !transition_validated):
		$RT_button.visible = true
		$HUD_changer_monde.visible = true
		if(Input.is_action_pressed("ui_kill")):
			$RT_button.visible = false
			$HUD_changer_monde.visible = false
			transition_validated = true
			
	if(mvt_left_validated && mvt_right_validated && jump_validated && transition_validated):
		$GoForGamelle.visible = true
		var t = Timer.new()
		t.set_wait_time(4)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$GoForGamelle.visible = false
		$TextureRect.visible = false
	
