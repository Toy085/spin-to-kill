extends Node2D

@export var crash_dialogue: DialogueResource

func _ready() -> void:
	if !Global.crash_scene:
		pass
	
	DialogueManager.show_example_dialogue_balloon(crash_dialogue, "start")
	
	await DialogueManager.dialogue_ended
	Global.crash_scene = true
