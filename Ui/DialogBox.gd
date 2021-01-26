extends Control

signal interaction_start
signal interaction_end

onready var label = $TextureRect/RichTextLabel
onready var tween = $Tween

var _text_lines: Array
var text_index: int = 0
var see_next_dialogue: bool
var ready_for_next_dialogue: bool
var showing_dialogue := false

var is_bed = false

func _physics_process(delta: float) -> void:
	see_next_dialogue = Input.is_action_just_pressed("interact")
	if showing_dialogue and see_next_dialogue:
		return
	if see_next_dialogue and ready_for_next_dialogue and text_index < len(_text_lines):
		show_dialog_text(_text_lines[text_index])

func _on_Interactible_interact(text_lines) -> void:
	emit_signal("interaction_start")
	visible = true
	text_index = 0
	_text_lines = text_lines
	if len(text_lines) != 0:
		show_dialog_text(text_lines[0])

func show_dialog_text(text: String):
	text = text.lstrip("\n")
	print(text)
	showing_dialogue = false
	if text == "FADE":
		print("fading")
		get_node("../ScreenFade").fade_to_black_and_back(2.0)
		ready_for_next_dialogue = true
		text_index += 1
		if text_index == len(_text_lines):
			if not is_bed:
				emit_signal("interaction_end")
				yield(get_tree().create_timer(1.0), "timeout")
				visible = false
				ready_for_next_dialogue = false
			else:
				# emit_signal("interaction_end")
				yield(get_tree().create_timer(1.0), "timeout")
				# emit_signal("game_over")
				print("END GAME")
	elif text == "FADE_TO_BLACK":
		print("fading only to black")
		get_node("../ScreenFade").fade_to_black(1.0)
		pass
	else:
		label.bbcode_text = text
		tween.interpolate_property(label, "percent_visible", 0.0, 1.0, text.length() / 20.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	showing_dialogue = false
	text_index = text_index + 1
	if text_index == len(_text_lines):
		if not is_bed:
			emit_signal("interaction_end")
			yield(get_tree().create_timer(1.0), "timeout")
			visible = false
			ready_for_next_dialogue = false
		else:
			# emit_signal("interaction_end")
			yield(get_tree().create_timer(1.0), "timeout")
			# emit_signal("game_over")
			print("END GAME")
	else:
		ready_for_next_dialogue = true



func _on_Bed_interact(text_lines) -> void:
	is_bed = true
	emit_signal("interaction_start")
	visible = true
	text_index = 0
	_text_lines = text_lines
	if len(text_lines) != 0:
		show_dialog_text(text_lines[0])
