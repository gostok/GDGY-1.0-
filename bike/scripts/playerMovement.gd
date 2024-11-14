extends Node

var offset_x = 0
var offset_y = 0
var max_offset_x = 1
var max_offset_y = 0.2
var move_speed = 100

@onready var head_player = $"../player/skelet_player/pins/HeadHolder/head"
@onready var body_player = $"../player/skelet_player/pins/Body_playerHolder/body_b"
@onready var hand_player = $"../player/skelet_player/pins/HandHolder/hand"
@onready var hip_player = $"../player/skelet_player/pins/HipHolder/hip"
@onready var shin_player = $"../player/skelet_player/pins/ShinHolder/shin"



func move_left(delta: float) -> void:

	if offset_x > -max_offset_x:
		offset_x -= move_speed * delta
		offset_y += move_speed * delta
		
		head_player.position.x = offset_x
		head_player.rotation = deg_to_rad(-15)
		
		body_player.position.x = offset_x
		body_player.position.y -= move_speed * delta
		body_player.rotation = deg_to_rad(22)
		
		hand_player.position.x = offset_x
		hand_player.rotation = deg_to_rad(-20)
		
		hip_player.position.x = offset_x
		hip_player.position.y -= move_speed * delta
		hip_player.rotation = deg_to_rad(-12)
		
		shin_player.position.x = offset_x
		shin_player.position.y -= move_speed * delta
		shin_player.rotation = deg_to_rad(-70)
	else:
		head_player.position.x = -1.4
		head_player.rotation = deg_to_rad(-15)
		
		body_player.position.x = -2
		body_player.position.y = -0.6
		body_player.rotation = deg_to_rad(22)
		
		hand_player.position.x = -1
		hand_player.rotation = deg_to_rad(-20)
		
		hip_player.position.x = -2.4
		hip_player.position.y = -1.2
		hip_player.rotation = deg_to_rad(-12)
		
		shin_player.position.x = -1
		shin_player.position.y = -1.2
		shin_player.rotation = deg_to_rad(-50)

func move_rigth(delta: float) -> void:

	if offset_x < max_offset_x:
		offset_x += move_speed * delta
		offset_y += move_speed * delta
		
		head_player.position.x = offset_x
		head_player.position.y = 0.8
		head_player.rotation = deg_to_rad(15)
		
		body_player.position.x = offset_x
		body_player.rotation = deg_to_rad(15)
		
		hand_player.position.x = offset_x
		hand_player.rotation = deg_to_rad(-10)
		
		hip_player.position.x = offset_x
		hip_player.rotation = deg_to_rad(40)
		
		shin_player.position.x -= move_speed * delta
		shin_player.rotation = deg_to_rad(-15)
	else:
		head_player.position.x = 2.6
		head_player.position.y = 0.8
		head_player.rotation = deg_to_rad(15)
		
		body_player.position.x = 2
		body_player.rotation = deg_to_rad(15)
		
		hand_player.position.x = 0.6
		hand_player.rotation = deg_to_rad(-10)
		
		hip_player.position.x = 0.6
		hip_player.rotation = deg_to_rad(40)
		
		shin_player.position.x = -0.5
		shin_player.rotation = deg_to_rad(-15)
