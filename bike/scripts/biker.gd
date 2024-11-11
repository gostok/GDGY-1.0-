extends RigidBody2D

@onready var movement = preload("res://bike/scripts/playerMovement.gd").new()

var wheels = []
var deceleration = 250
var speed = 100
var max_speed = 20.0
var tilt_angle = 2  # Угол наклона
var tilt_return_speed = 5.0  # Скорость возвращения наклона в нейтральное положение
var rotation_speed = 0  # Скорость наклона




@onready var wheel_back = $WheelHolder_Back/wheel



func _ready() -> void:
	add_child(movement)

func _physics_process(delta: float) -> void:
	gravity_scale = 1

	
	if Input.is_action_pressed("right"):
		tilt_right(delta)
		movement.move_rigth(delta)
		motor_force(speed)
	elif Input.is_action_pressed("left"):
		tilt_left(delta)
		movement.move_left(delta)
		motor_force(speed)
	else:
		reset_tilt(delta)
		motor_force(0)
		
	rotation += rotation_speed * delta
	
	linear_velocity.x = move_toward(linear_velocity.x, max_speed * sign(rotation_speed), deceleration * delta)

func motor_force(direction: float) -> void:
	if wheel_back.angular_velocity < max_speed:
		wheel_back.apply_torque_impulse(direction * 50)

func tilt_left(delta: float) -> void:
	# Наклон влево
	rotation_speed = max(rotation_speed - tilt_angle * delta, -tilt_angle)


func tilt_right(delta: float) -> void:
	# Наклон вправо
	rotation_speed = min(rotation_speed + tilt_angle * delta, tilt_angle)

func reset_tilt(delta: float) -> void:
	# Возвращение в нейтральное положение
	if abs(rotation_speed) < 0.01:
		rotation_speed = 0
	else:
		rotation_speed = move_toward(rotation_speed, 0, tilt_return_speed * delta)
	# Ограничиваем угол наклона
	rotation = clamp(rotation, -360, 360)

func move_toward(current: float, target: float, delta: float) -> float:
	if current > target:
		return max(current - delta, target)
	elif current < target:
		return min(current + delta, target)
	return target
