extends HSlider

@export var audio_bus_name: String

@onready var audio_control: HSlider = $"."

var audio_bus_id

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus_name)
	if audio_bus_id != -1:
		audio_control.value = AudioServer.get_bus_volume_linear(audio_bus_id)
	else:
		push_error("Audio bus '" + audio_bus_name + "' not found.")
func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	if audio_bus_id != -1:
		AudioServer.set_bus_volume_db(audio_bus_id, db)
