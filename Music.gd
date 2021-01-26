extends Node2D

onready var music = [
	$AudioStreamPlayer,
	$AudioStreamPlayer2
]

func _ready() -> void:
	music[0].play(1.0)
	music[1].stop()

func _on_AudioStreamPlayer_finished() -> void:
	music[1].play()
	music[0].stop()

func _on_AudioStreamPlayer2_finished() -> void:
	music[0].play()
	music[1].stop()
