extends Node2D

const Effect = preload("res://scenes/grass_effect.tscn")

# warning-ignore:unused_argument
func death():
	var effect_inst = Effect.instance()

	get_parent().add_child(effect_inst)
	effect_inst.global_position = global_position

func _on_hurtbox_area_entered(area: Area2D) -> void:
	death()
	queue_free()
