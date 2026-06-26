extends CharacterBody2D

@onready var axe_pivot: Node2D = $AxePivot
@onready var cooldown_timer = $Timer

@export var speed : float = 300
@export var spin_speed: float = 12

var is_spinning: bool = false

func _ready() -> void:
	cooldown_timer.wait_time = Global.cooldown
	Global.health = Global.max_health

func _physics_process(delta:float) -> void:
	var input_vector = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_vector * speed
	move_and_slide()

	if Input.is_action_just_pressed("attack") and not is_spinning and cooldown_timer.is_stopped():
		is_spinning = true
		axe_pivot.show()

	if is_spinning:
		axe_pivot.rotation += spin_speed * delta

		if axe_pivot.rotation >= TAU: # Stop rotation at 360
			axe_pivot.rotation = 0
			is_spinning = false
			axe_pivot.hide()
			cooldown_timer.start()
			
func damage(damage: int) -> void:
	Global.health -= damage
	
	if Global.health <= 0:
		Global.player_died()
