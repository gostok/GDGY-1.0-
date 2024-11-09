extends RigidBody2D

@onready var movement = preload("res://bike/scripts/playerMovement.gd").new()

var wheels = []
var deceleration = 250
var speed = 0
var max_speed = 20.0
var tilt_angle = 110  # Угол наклона
var tilt_return_speed = 0.8  # Скорость возвращения наклона в нейтральное положение
var target_rotation = 0  # Целевое значение для наклонанаклона
var velocity = Vector2.ZERO



@onready var wheel_back = $WheelHolder_Back/wheel



func _ready() -> void:
	wheels = [wheel_back]
	add_child(movement)

func _physics_process(delta: float) -> void:
	gravity_scale = 1
	velocity.y += gravity_scale * delta
	
	if Input.is_action_pressed("right"):
		#tilt_right(delta)
		movement.move_rigth(delta)
		for wheel in wheels:
			if wheel.angular_velocity < max_speed:
				wheel.apply_torque_impulse(speed * delta * 30)
	elif Input.is_action_pressed("left"):
		#tilt_left(delta)
		movement.move_left(delta)
		for wheel in wheels:
			if wheel.angular_velocity < max_speed:
				wheel.apply_torque_impulse(speed * delta * 30)
	else:
		reset_tilt(delta)
		
		if linear_velocity.x != 0:
			linear_velocity.x = move_toward(linear_velocity.x, 0, deceleration * delta)
	
	rotation = target_rotation


func tilt_left(delta: float) -> void:
	# Наклон влево
	target_rotation -= deg_to_rad(tilt_angle * delta * 0.5)  # Уменьшите множитель


func tilt_right(delta: float) -> void:
	# Наклон вправо
	target_rotation += deg_to_rad(tilt_angle * delta * 0.5)  # Уменьшите множитель




func reset_tilt(delta: float) -> void:
	# Возвращение в нейтральное положение
	target_rotation = move_toward(target_rotation, 0, tilt_return_speed * delta)

func move_toward(current: float, target: float, delta: float) -> float:
	if current > target:
		return max(current - delta, target)
	elif current < target:
		return min(current + delta, target)
	return target
