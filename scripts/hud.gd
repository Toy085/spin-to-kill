extends Control

@onready var coinlabel: RichTextLabel = $CoinLabel
@onready var healthbar: ProgressBar = $HealthBar

func _ready() -> void:
	healthbar.max_value = Global.health

func _process(_delta: float) -> void:
	coinlabel.text = "%s [outline_size=6][color=gold]%s[/color][/outline_size]" % [tr("KEY_COINS"), Global.current_run_money]
	healthbar.value = Global.health
	print(tr("KEY_COINS"))
