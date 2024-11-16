extends Node2D

var SPEED = 500
var velocity: Vector2
var parent: Node2D
 
func _process(delta: float) -> void:
	velocity = delta * SPEED * transform.x
	global_position += velocity
	
	var collisions = $Area2D.get_overlapping_bodies()
	if len(collisions) != 0:
		var collision = collisions[0]
		if parent == collision:
			return
		print("collided")
		if collision.get_class() == "CharacterBody2D":
			collision.damage()
			print("Hit player")
		queue_free()
