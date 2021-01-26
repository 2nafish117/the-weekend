extends Node2D

signal interact

var interacted := false
var player = null

var bed_early: String = """Ah fuck it, im really tired today. Off to bed;
Will wake up nice and late tomorrow;
Gn player;
ZZZZZZZZZZZZZZ;
Game Over: BAD ENDING (you dint relax enough);
FADE_TO_BLACK
	"""

var bed_late: String = """Yawn, need sleep;
Not bad for a day i guess;
Gn player;
ZZZZZZZZZZZZZZ;
Game Over: GOOD ENDING?;
FADE_TO_BLACK
	"""

export(bool) var can_move := false

func _physics_process(delta: float) -> void:
	if player != null and not interacted and Input.is_action_just_pressed("interact"):
		interacted = true
		player.interact(can_move)
		player.add_points(0.0)
		if player.points >= 10:
			emit_signal("interact", bed_late.split(";", false))
		else:
			emit_signal("interact", bed_early.split(";", false))

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		player = body


func _on_Area2D_body_exited(body: Node) -> void:
	if body is Player:
		player = null
