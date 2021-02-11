extends KinematicBody2D

export var exelration = 100
export var speed = 200
export var friction = 100

enum {
	move,
	roll,
	attack
}

var state = move
var roll_vector = Vector2.DOWN

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

onready var sword = $Position2D/hitbox

# warning-ignore:unused_argument
func _process(delta: float) -> void:
	match state:
		move:
			move_state(delta)
		roll:
			roll_state()
		attack:
			attack_state()

func move_state(_delta: float):
	input_to_move(_delta)

func input_to_move(delta):
	var velocity = Vector2.ZERO
	var _input_vector = User_Input(Vector2.ZERO)
	var movement = check_for_movement(_input_vector, velocity)

# warning-ignore:return_value_discarded
	move_and_slide(movement)
	animations(_input_vector)
	if Input.is_action_just_pressed("attack_attack"):
		state = attack
	if Input.is_action_just_pressed("roll"):
		state = roll

func animations (_movement):
	if _movement != Vector2.ZERO:
		roll_vector = _movement
		sword.knockback_vector = _movement
		animation_tree.set("parameters/walk/blend_position", _movement)
		animation_tree.set("parameters/idle/blend_position", _movement)
		animation_tree.set("parameters/attack/blend_position", _movement)
		animation_tree.set("parameters/roll/blend_position", _movement)
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

func roll_state():
	animation_state.travel("roll")
	_move()

func _move():
	var velocity = Vector2.ZERO
	var _input_vector = roll_vector * speed
	var movement = check_for_movement(_input_vector, velocity)
# warning-ignore:return_value_discarded
	move_and_slide(movement)

func state_finished():
	state= move

