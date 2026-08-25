@icon("res://addons/at-icons/node2d/info.svg")
extends Node2D

var distance_player
var player: CharacterBody2D
var tut = self

@export var tutorial_dialouge: DialogueResource

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	if player:
		player.set_physics_process(false)
	
	DialogueManager.show_example_dialogue_balloon(tutorial_dialouge, "start", [self])
	await DialogueManager.dialogue_ended

func wait_for_player_distance(target_distance: float) -> void:
	if not player:
		return
		
	player.set_physics_process(true)

	var start_pos: Vector2 = player.global_position
	
	while player.global_position.distance_to(start_pos) < target_distance:
		await get_tree().process_frame
	
	player.set_physics_process(false)


func wait_for_player_spin_attack() -> void:
	if not player:
		return
		
	player.set_physics_process(true)

	while not player.is_spinning:
		await get_tree().process_frame
	
	await get_tree().create_timer(0.75).timeout
	player.set_physics_process(false)

func wait_for_player_throw() -> void:
	if not player:
		return
	
	player.set_physics_process(true)

	await player.axe_thrown
	await get_tree().create_timer(0.75).timeout
	
	player.set_physics_process(false)

func quit() -> void:
	Global.done_tutorial = true
	await Global.save_game()
	get_tree().change_scene_to_file("res://world.tscn")
