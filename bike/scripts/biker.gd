extends RigidBody2D

signal died

enum State {
	IDLE,
	MOVING_LEFT,
	MOVING_RIGHT,
	DEATH
}

var current_state = State.IDLE


@onready var movement = preload("res://bike/scripts/playerMovement.gd").new()
@onready var wheel_back = $wheels/WheelHolder_Back/wheel_back
@onready var wheel_area_back = $wheels/WheelHolder_Back/wheel_back/Area2D_back


var wheels = []
var deceleration = 5000
var speed = 3000
var max_speed = 16

var is_alive = true
var is_on_ground_back = false  # Переменная для отслеживания состояния заднего колеса
var current_speed = 0.0  # Текущая скорость

func _ready() -> void:
	add_child(movement)

func _physics_process(delta: float) -> void:

	handle_input(delta)
	update_movement(delta)

	if Input.is_action_pressed("run"):
		if wheel_back.angular_velocity < max_speed:
			wheel_back.apply_torque_impulse(speed * delta * 60)
	if Input.is_action_just_pressed("run") or is_on_ground_back==false:
		wheel_back.angular_velocity = max(0, current_speed - deceleration * delta * 60)
	if Input.is_action_pressed("stop"):
		wheel_back.angular_velocity = 0

	if Input.is_action_pressed("reset"):
		get_tree().change_scene_to_file("res://all_scenes/test_scene/test_scene.tscn")

func handle_input(delta: float):


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




func update_movement(delta: float):
	var torque = 0
	var acceleration = 0

	match current_state:
		State.IDLE:
			pass
		State.MOVING_RIGHT:
			movement.move_rigth(delta)
			torque = 40
			acceleration = speed * delta * 60
		State.MOVING_LEFT:
			movement.move_left(delta)
			torque = -40
			acceleration = speed * delta * 60
		State.DEATH:
			death_player()

	# Применяем крутящий момент
	apply_torque_impulse(torque * delta * 30)

	# Применяем силу для движения
	apply_impulse(Vector2(0, 0), Vector2(acceleration * delta, 0))

	# Применяем текущую скорость
	apply_impulse(Vector2(0, 0), Vector2(current_speed * delta, 0))

func death_player():
	is_alive = false
	emit_signal("died")
	call_deferred("queue_free")
	call_deferred("_change_scene")

func _change_scene():
	get_tree().change_scene_to_file("res://all_scenes/test_scene/test_scene.tscn")

func _on_head_death_body_entered(body) -> void:
	if body is StaticBody2D:
		current_state = State.DEATH

func _on_body_death_body_entered(body) -> void:
	if body is StaticBody2D:
		current_state = State.DEATH

func _on_hand_death_body_entered(body) -> void:
	if body is StaticBody2D:
		current_state = State.DEATH

func _on_area_2d_back_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		is_on_ground_back = true


func _on_area_2d_back_body_exited(body: Node2D) -> void:
	if body is StaticBody2D:
		is_on_ground_back = false
