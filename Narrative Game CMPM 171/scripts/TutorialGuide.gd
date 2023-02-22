extends Area2D

var active = false

# the 2x2 list of dialogue
var d_list1 = ["guide-dialogue"]
var d_list2 = []
onready var d_events = [d_list1, d_list2]

export (int) var pos_x = 0
export (int) var pos_y = 0

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')


func _process(delta):
	$Icon.visible = active


func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
