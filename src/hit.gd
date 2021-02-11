extends AnimatedSprite


func _ready() -> void:
	connect("animation_finished", self,"_on_AnimatedSprite_animation_finished")
	frame = 0
	play("effect")

func _on_AnimatedSprite_animation_finished() -> void:
	queue_free()
