extends CharacterBody2D
class_name Player

const SPEED = 5000
@export var controller_index: int = -1
var last_move_position = Vector2(0, 1)
var x_vel
var y_vel
var look_pos = Vector2(1, 1)
var shell = preload("res://scenes/shell.tscn")
var shoot_button_pressed = false

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

func shoot():
	var shell_scene = shell.instantiate()
	print($TankParts/Barrel/ShootMarker.global_position)
	get_node("../../Bullets").add_child(shell_scene)
	shell_scene.global_position = $TankParts/Barrel/ShootMarker.global_position
	shell_scene.rotation = $TankParts/Barrel.rotation
	print(shell_scene.global_position)

func _physics_process(delta):
	x_vel = Input.get_joy_axis(controller_index, JOY_AXIS_LEFT_X)
	y_vel = Input.get_joy_axis(controller_index, JOY_AXIS_LEFT_Y)
	
	velocity = Vector2(x_vel, y_vel).normalized() * SPEED * delta
	
	rotate_player_body()
	rotate_player_barrel()
	
	if Input.is_joy_button_pressed(controller_index, JOY_BUTTON_RIGHT_SHOULDER):
		if not shoot_button_pressed:
			print("shooting")
			shoot()
		shoot_button_pressed = true
	else:
		shoot_button_pressed = false
	
	move_and_slide()
