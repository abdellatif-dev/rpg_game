extends KinematicBody2D

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var stat = $stats
onready var sprite = $Bat

onready var player_detection = $player_dection_zone

export var exelration = 90
export var speed = 90
export var friction = 50
export(int) var knockbak_friction: int = 200

const Effect = preload("res://scenes/bat_effect.tscn")

enum{
	idle,
	wander,
	chase
}

var state = idle

func _physics_process(delta: float) -> void:
	knockback = knockback.move_toward(Vector2.ZERO, knockbak_friction * delta)
	knockback = move_and_slide(knockback)

	match state:
		idle:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
		wander:
			pass
		chase:
			var player = player_detection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction* speed, exelration * delta)
			else:
				state = idle

			sprite.flip_h = velocity.x < 0

	velocity = move_and_slide(velocity)

func seek_player():
	if player_detection.can_see_player():
		state = chase

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

