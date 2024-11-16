extends Node2D


func setup_players(player_count: int):
	var player_scene = preload("res://scenes/player.tscn")
	
	if player_count > len(Input.get_connected_joypads()):
		print("BAD PLAYER COUNT")
		queue_free()
	
	for player_controller_id in range(player_count):
		var player_object = player_scene.instantiate()
		player_object.controller_index = player_controller_id
		player_object.position.x += player_controller_id * 15
		add_child(player_object)
