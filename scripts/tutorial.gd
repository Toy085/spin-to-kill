@icon("res://addons/at-icons/node/info.svg")
extends Node2D

var distance_player
var player: CharacterBody2D
var tut = self

@export var tutorial_dialouge: DialogueResource

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
	DialogueManager.show_example_dialogue_balloon(tutorial_dialouge, "start", [self])
	await DialogueManager.dialogue_ended

func wait_for_player_distance(target_distance: float) -> void:
	if not player:
		return
	
	var start_pos: Vector2 = player.global_position
	
	while player.global_position.distance_to(start_pos) < target_distance:
		await get_tree().process_frame

func wait_for_player_spin_attack() -> void:
	if not player:
		return
	
	while not player.is_spinning:
		await get_tree().process_frame

func wait_for_player_throw() -> void:
	if not player:
		return
	
	while not Input.is_action_just_pressed("throw_axe"):
		await get_tree().process_frame

func quit() -> void:
	Global.done_tutorial = true
	Global.save_game()
	get_tree().change_scene_to_file("res://world.tscn")
