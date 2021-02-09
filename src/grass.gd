extends Node2D


# warning-ignore:unused_argument
func death():
	var GrassEffect = load("res://scenes/grass_effect.tscn")

	var grass_effect = GrassEffect.instance()

	var world = get_tree().current_scene
	world.add_child(grass_effect)
	grass_effect.global_position = global_position


func _on_hurtbox_area_entered(area: Area2D) -> void:
	death()
	queue_free()
