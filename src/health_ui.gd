extends Control

export var heart = 10 setget  set_heart
export var max_heart = 10 setget set_max_heart

onready var heart_full = $heat_full
onready var heart_mt = $heat_mt

func _ready() -> void:
	self.max_heart = PlayerStats.max_health
	self.heart = PlayerStats.health
# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_heart")

func set_heart(value):
	heart = clamp(value, 0, max_heart)
	if heart_full != null:
		heart_full.rect_size.x = heart * 15

func set_max_heart(value):
	max_heart = max(value, 1)
