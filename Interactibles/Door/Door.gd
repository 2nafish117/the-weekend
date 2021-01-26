extends Node2D

signal interact

var start_text_lines = """Ahhh finally home, after a long day at work.;
If it werent for that fatass kerbie id have finished hours ago.;
He just had to mess up the reports that were due monday;
Anyway i can relax the whole weekend."""

#var start_text_lines = """line1;line2"""

var inter: bool = false

func _physics_process(delta: float) -> void:
	if not inter:
		emit_signal("interact", start_text_lines.split(";", false))
		inter = true
