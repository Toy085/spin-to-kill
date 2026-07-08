extends CharacterBody2D

@onready var axe_pivot: Node2D = $AxePivot
@onready var cooldown_timer = $Timer
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var footstep_player: AudioStreamPlayer2D = $Footstep
@onready var axe_scene: PackedScene = preload("res://axe.tscn")

@export var speed: float = Global.speed
@export var spin_speed: float = 12

var is_spinning: bool = false
var spin_cw: bool = true

func _ready() -> void:
	cooldown_timer.wait_time = Global.cooldown
	Global.health = Global.max_health
	speed = Global.speed
	
	if Global.health <= 0:
		Global.player_died()

func _physics_process(delta:float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * speed
	if anim and velocity != Vector2.ZERO:
		anim.play()
		if !footstep_player.playing:
			footstep_player.pitch_scale = randf_range(.8, 1.2)
			footstep_player.play()
			
	else:
		anim.pause()
	
	move_and_slide()

	if Input.is_action_just_pressed("spin_cw") and not is_spinning and cooldown_timer.is_stopped():
		is_spinning = true
		axe_pivot.show()
		spin_cw = true
	elif Input.is_action_just_pressed("spin_ccw") and not is_spinning and cooldown_timer.is_stopped():
		is_spinning = true
		axe_pivot.show()
		spin_cw = false

	if is_spinning and spin_cw:
		axe_pivot.rotation += spin_speed * delta
		if axe_pivot.rotation >= TAU: # Stop rotation at 360
			axe_pivot.rotation = 0
			is_spinning = false
			axe_pivot.hide()
			cooldown_timer.start()
	elif is_spinning and not spin_cw:
		axe_pivot.rotation -= spin_speed * delta
		if axe_pivot.rotation <= -TAU:
			axe_pivot.rotation = 0
			is_spinning = false
			axe_pivot.hide()
			cooldown_timer.start()
	
	if Input.is_action_just_pressed("throw_axe") and cooldown_timer.is_stopped():
		throw_axe()

func throw_axe() -> void:
	if not axe_scene:
		return
	
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()
	
	var axe_instance = axe_scene.instantiate() as Axe
	
	axe_instance.Thrown = true
	axe_instance.pos = global_position + (dir * 100)
	axe_instance.global_position = global_position
	
	get_parent().add_child(axe_instance)
	
	cooldown_timer.start()


func damage(damage: int) -> void:
	Global.health -= damage
	
	if Global.health <= 0:
		Global.player_died()
