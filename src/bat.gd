extends KinematicBody2D

var knockback = Vector2.ZERO

onready var stat = $stats


const Effect = preload("res://scenes/bat_effect.tscn")


func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	stat.health -= area.damage
	knockback = area.knockback_vector * 120


func _on_stats_no_health() -> void:
	death()
	queue_free()


# warning-ignore:unused_argument
func death():
	var effect_inst = Effect.instance()

	get_parent().add_child(effect_inst)
	effect_inst.global_position = global_position

