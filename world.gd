extends Node2D

@export var crash_dialogue: DialogueResource

var player: CharacterBody2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if Global.crash_scene:
		return
		
	player.visible = false
	DialogueManager.show_example_dialogue_balloon(crash_dialogue, "start")
	
	await DialogueManager.dialogue_ended
	Global.crash_scene = true
	player.visible = true
