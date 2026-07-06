extends Control

@export var game_scene_path : String = "res://world.tscn"

@onready var options: Panel = $Options

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(game_scene_path)

func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_options_button_pressed() -> void:
	options.visible = true
