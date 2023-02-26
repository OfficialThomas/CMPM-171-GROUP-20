extends Control


onready var gui = get_node("../../GUI")
onready var world = get_node("../../")
var introScript;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Start_pressed():
	world.start_game()
	gui.get_node("IntroMenu").queue_free()
