extends Control

func fade_to_black_and_back(duration: float):
	$AnimationPlayer.play("fade_to_black_and_back")
	$AnimationPlayer.playback_speed = 1.0 / duration

func fade_to_black(duration: float) -> void:
	$AnimationPlayer.play("fade_to_black")
	$AnimationPlayer.playback_speed = 1.0 / duration

func unfade_to_transparent(duration: float) -> void:
	$AnimationPlayer.play("unfade_to_transparent")
	$AnimationPlayer.playback_speed = 1.0 / duration

