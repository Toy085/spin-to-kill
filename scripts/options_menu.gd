@icon("res://addons/at-icons/control/dropdown.svg")
extends Panel

@onready var options: Panel = $"."

func _on_back_button_pressed() -> void:
	options.visible = false


func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
