extends Node

var offset_x = 0
var offset_y = 0
var max_offset_x = 5
var max_offset_y = 1
var move_speed = 100

@onready var head_player = $"../player/skelet_player/pins/HeadHolder/head"
@onready var body_player = $"../player/skelet_player/pins/Body_playerHolder/body_player"
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
		head_player.position.x = -7
		head_player.rotation = deg_to_rad(-15)
		
		body_player.position.x = -10
		body_player.position.y = -3
		body_player.rotation = deg_to_rad(22)
		
		hand_player.position.x = -5
		hand_player.rotation = deg_to_rad(-20)
		
		hip_player.position.x = -12
		hip_player.position.y = -6
		hip_player.rotation = deg_to_rad(-12)
		
		shin_player.position.x = -6
		shin_player.position.y = -6
		shin_player.rotation = deg_to_rad(-70)

func move_rigth(delta: float) -> void:

	if offset_x < max_offset_x:
		offset_x += move_speed * delta
		offset_y += move_speed * delta
		
		head_player.position.x = offset_x
		head_player.position.y = 4
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
		head_player.position.x = 13
		head_player.position.y = 4
		head_player.rotation = deg_to_rad(15)
		
		body_player.position.x = 10
		body_player.rotation = deg_to_rad(15)
		
		hand_player.position.x = 3
		hand_player.rotation = deg_to_rad(-10)
		
		hip_player.position.x = 3
		hip_player.rotation = deg_to_rad(40)
		
		shin_player.position.x = -5
		shin_player.rotation = deg_to_rad(-15)
