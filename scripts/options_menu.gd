@icon("res://addons/at-icons/control/dropdown.svg")
extends Panel

@onready var options: Panel = $"."
@onready var audio_control: HSlider = $VBoxContainer/MasterSliderLabel/AudioControl

func _on_back_button_pressed() -> void:
	options.visible = false

func _ready() -> void:
	audio_control.grab_focus()

func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
