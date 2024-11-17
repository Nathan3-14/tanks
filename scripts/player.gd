extends CharacterBody2D
class_name Player

const SPEED = 8500
@export var controller_index: int = -1
var last_move_position = Vector2(0, 1)
var x_vel
var y_vel
var look_pos = Vector2(1, 1)
var shell = preload("res://scenes/shell.tscn")
var health = 5

func rotate_player_body():
	if velocity != Vector2(0, 0):
		last_move_position = Vector2(x_vel, y_vel)
	
	$TankParts/Body.rotation = last_move_position.angle()


func damage():
	self.health -= 1
	$PlayerInfo/HealthBar.value = self.health
	if health <= 0:
		queue_free()


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
	shell_scene.parent = self
	print(shell_scene.global_position)
	$PlayerInfo/Reload.value = 0
	$AnimationPlayer.play("Shoot") #! Make animation be proportional to the direction of barrel (maybe not in animationplayer)

func _physics_process(delta):
	if controller_index == -1:
		return
	
	x_vel = Input.get_joy_axis(controller_index, JOY_AXIS_LEFT_X)
	y_vel = Input.get_joy_axis(controller_index, JOY_AXIS_LEFT_Y)
	
	velocity = Vector2(x_vel, y_vel).normalized() * SPEED * delta
	
	rotate_player_body()
	rotate_player_barrel()
	
	if Input.is_joy_button_pressed(controller_index, JOY_BUTTON_RIGHT_SHOULDER):
		if $PlayerInfo/Reload.value == 10:
			shoot()
			print("shooting")
	
	if $PlayerInfo/Reload.value < 10:
		$PlayerInfo/Reload.value += delta * 10
	
	move_and_slide()
