extends CanvasLayer

func _ready():
	$ColorRect.visible = false;
	$ColorRect.set_frame_color(Color(0,0,0,0))


func transition_from_day_to_death():
	$ColorRect.visible = true;
	$AnimationPlayer.play("from_day_to_death");


func transition_from_death_to_day():
	$ColorRect.visible = true;
	$AnimationPlayer.play("from_death_to_day");


func _on_AnimationPlayer_animation_finished(anim_name):
	if "from_day_to_death".is_subsequence_of($AnimationPlayer.get_animation()):
		$ColorRect.visible = false
		$ColorRect.set_frame_color(Color(0,0,0,0))
	if "from_death_to_day".is_subsequence_of($AnimationPlayer.get_animation()):
		$ColorRect.visible = false
		$ColorRect.set_frame_color(Color(0,0,0,0))
