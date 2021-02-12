extends Area2D

const _Effect = preload("res://scenes/hit.tscn")
export var hit_bool = false
func _on_hurtbox_area_entered(area: Area2D) -> void:
	if hit_bool:
		var _Effect_inst = _Effect.instance()
		get_parent().add_child(_Effect_inst)
		_Effect_inst.global_position = global_position - Vector2(0, 9)
