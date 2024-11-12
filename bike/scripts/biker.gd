extends RigidBody2D

enum State {
	IDLE,
	MOVING_LEFT,
	MOVING_RIGHT
}

var current_state = State.IDLE

var is_frozen = false
var freeze_time = 0.1  # Время заморозки в секундах
var freeze_timer = 0.0  # Таймер для отслеживания времени заморозки

@onready var movement = preload("res://bike/scripts/playerMovement.gd").new()
@onready var wheel_back = $WheelHolder_Back/wheel

var wheels = []
var deceleration = 200
var speed = 2000
var max_speed = 30


func _ready() -> void:
	add_child(movement)

func _physics_process(delta: float) -> void:
	if is_frozen:
		freeze_timer -= delta
		if freeze_timer <= 0:
			is_frozen = false
			current_state = State.IDLE
	else:
		handle_input(delta)
		update_movement(delta)

	if Input.is_action_pressed("jump"):
		if wheel_back.angular_velocity < max_speed:
			wheel_back.apply_torque_impulse(speed * delta * 60)


func handle_input(delta: float):
	if is_frozen:
		return

	var is_right_pressed = Input.is_action_pressed("right")
	var is_left_pressed = Input.is_action_pressed("left")

	if is_right_pressed and !is_left_pressed:
		if current_state != State.MOVING_RIGHT:
			current_state = State.MOVING_RIGHT

	elif is_left_pressed and !is_right_pressed:
		if current_state != State.MOVING_LEFT:
			current_state = State.MOVING_LEFT

	else:
		current_state = State.IDLE

	if !is_left_pressed and !is_right_pressed:
		freeze_state()


func freeze_state():
	is_frozen = true
	freeze_timer = freeze_time

func update_movement(delta: float):
	match current_state:
		State.IDLE:
			pass
		State.MOVING_RIGHT:
			movement.move_rigth(delta)
			apply_torque_impulse(600 * delta * 60)
		State.MOVING_LEFT:
			movement.move_left(delta)
			apply_torque_impulse(-600 * delta * 60)
