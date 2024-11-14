extends Control

var start_colour = Color("4c4c4cc9")
@onready var world = get_parent().get_node("World")

# Called when the node enters the scene tree for the first time.
func _ready():
	world.modulate = start_colour

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _start_button_pressed():
	world.get_node("AnimationPlayer").play("fade")
	$AnimationPlayer.play("fade")
	get_node("../World/Entities/Players").setup_players($OptionButton.selected+1)
