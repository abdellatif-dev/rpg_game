extends Node2D


# warning-ignore:unused_argument
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack_attack"):
		var GrassEffect = load("res://scenes/grass_effect.tscn")

		var grass_effect = GrassEffect.instance()

		var world = get_tree().current_scene
		world.add_child(grass_effect)
		grass_effect.global_position = global_position
		queue_free()
