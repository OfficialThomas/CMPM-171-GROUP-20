extends Area2D

onready var _sfx_output := $AudioStreamPlayer2D
var pipes = preload("res://assets/sound/Machines_V2.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	_sfx_output.stream = pipes

func _on_Node2D_body_entered(body):
	if body.name == "Player":
		_sfx_output.play()


func _on_Node2D_body_exited(body):
	if body.name == "Player":
		_sfx_output.stop()
