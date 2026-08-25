@icon("res://addons/at-icons/node/info.svg")
extends Node2D

var distance_player
var player: CharacterBody2D

@export var tutorial_dialouge: DialogueResource

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	DialogueManager.show_example_dialogue_balloon(tutorial_dialouge, "start")
	await DialogueManager.dialogue_ended

func _process(_delta: float) -> void:
	distance_player = global_position.direction_to(player.global_position)
