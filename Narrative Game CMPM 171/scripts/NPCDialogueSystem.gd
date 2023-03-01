extends Area2D

var active = false

# the 2d list of dialogue
var d_default = ["Test"]
var d_guide = ["Guide"]
var d_start = ["Opening"]
var d_brother = ["Meeting Brother"]
var d_worker = ["Meeting Worker"]
var d_manager = ["Meeting Manager"]
onready var d_events = [d_default, d_guide, d_start, d_brother, d_worker, d_manager]

export (int) var pos_x = 0
export (int) var pos_y = 0

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')


func _process(_delta):
	$AnimatedSprite.play("idle")
	$Icon.visible = active


func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false

