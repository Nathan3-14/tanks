extends CharacterBody2D
class_name Player

const SPEED = 5000
@export var controller_index: int = -1
var last_move_position = Vector2(0, 1)
var x_vel
var y_vel
var look_pos = Vector2(1, 1)

func rotate_player_body():
	if velocity != Vector2(0, 0):
		last_move_position = Vector2(x_vel, y_vel)
	
	$TankParts/Body.rotation = last_move_position.angle()


func rotate_player_barrel():
	var look_vector = Vector2(
		Input.get_joy_axis(controller_index, JOY_AXIS_RIGHT_X),
		Input.get_joy_axis(controller_index, JOY_AXIS_RIGHT_Y)
	)
	if look_vector != Vector2(0, 0):
		look_pos = look_vector
	$TankParts/Barrel.rotation = look_pos.angle()

func _physics_process(delta):
	x_vel = Input.get_joy_axis(controller_index, JOY_AXIS_LEFT_X)
	y_vel = Input.get_joy_axis(controller_index, JOY_AXIS_LEFT_Y)
	
	velocity = Vector2(x_vel, y_vel).normalized() * SPEED * delta
	
	rotate_player_body()
	rotate_player_barrel()
	
	move_and_slide()
