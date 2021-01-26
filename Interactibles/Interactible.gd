extends Node2D

signal interact

export(String, MULTILINE) var text_lines
export(bool) var can_move := false
export(float) var points := 0.0

var interacted := false
var player = null

func _physics_process(delta: float) -> void:
	if player != null and not interacted and Input.is_action_just_pressed("interact"):
		interacted = true
		player.interact(can_move)
		player.add_points(points)
		emit_signal("interact", text_lines.split(";", false))

func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		player = body

func _on_Area2D_body_exited(body: Node) -> void:
	if body is Player:
		player = null
