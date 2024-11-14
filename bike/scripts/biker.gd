extends RigidBody2D

signal died

enum State {
	IDLE,
	MOVING_LEFT,
	MOVING_RIGHT,
	DEATH
}

var current_state = State.IDLE

var is_frozen = false
var freeze_time = 0.1  # Время заморозки в секундах
var freeze_timer = 0.0  # Таймер для отслеживания времени заморозки

@onready var movement = preload("res://bike/scripts/playerMovement.gd").new()
@onready var wheel_back = $wheels/WheelHolder_Back/wheel_back

var wheels = []
var deceleration = 200
var speed = 600
var max_speed = 30

var is_alive = true


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
			wheel_back.apply_torque_impulse(speed * delta * 20)


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
			apply_torque_impulse(20 * delta * 30)
		State.MOVING_LEFT:
			movement.move_left(delta)
			apply_torque_impulse(-10 * delta * 30)





func death_player():
	is_alive = false
	emit_signal("died")
	queue_free()
	get_tree().change_scene_to_file("res://all_scenes/levels/level_1/level_1_0.tscn")



func _on_head_death_body_entered(body) -> void:
	if body is StaticBody2D:
		death_player()


func _on_body_death_body_entered(body) -> void:
	if body is StaticBody2D:
		death_player()


func _on_hand_death_body_entered(body) -> void:
	if body is StaticBody2D:
		death_player()
