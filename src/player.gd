extends KinematicBody2D

const exelration = 100
const speed = 200
const friction = 100

enum {
	move,
	roll,
	attack
}

var state = move

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

# warning-ignore:unused_argument
func _process(delta: float) -> void:
	match state:
		move:
			move_state(delta)
		roll:
			pass
		attack:
			attack_state()

func move_state(delta: float):
	var velocity = Vector2.ZERO
	var _input_vector = User_Input(Vector2.ZERO)
	var movement = check_for_movement(_input_vector, velocity)

# warning-ignore:return_value_discarded
	move_and_slide(movement)
	animations(_input_vector)
	if Input.is_action_just_pressed("attack_attack"):
		state = attack

func animations (_movement):
	if _movement != Vector2.ZERO:
		animation_tree.set("parameters/walk/blend_position", _movement)
		animation_tree.set("parameters/idle/blend_position", _movement)
		animation_tree.set("parameters/attack/blend_position", _movement)
		animation_state.travel("walk")
	else:
		animation_state.travel("idle")

func User_Input (_vector: Vector2):
	_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	return _vector.normalized()
func check_for_movement(input_vector: Vector2, velocity: Vector2):
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * speed, exelration)

	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction)

	return velocity

func attack_state():
	animation_state.travel("attack")

func finished_attack():
	state= move
