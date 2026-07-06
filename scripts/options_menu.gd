extends Panel

@onready var options: Panel = $"."



func _on_back_button_pressed() -> void:
	options.visible = false


func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.
