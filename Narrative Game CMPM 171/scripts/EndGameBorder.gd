extends Node2D

var player = null
export (bool) var enabled = false
export (int) var pos_x = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Border_body_entered(body):
	if body.name == "Player":
		player = body
		if enabled:
			get_tree().paused = true
			var dialog = Dialogic.start("EndBorder")
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			add_child(dialog)
			dialog.connect('timeline_end', self, 'unpause')
			dialog.connect('dialogic_signal', self, 'dialogic_signal')

func _on_Border_body_exited(body):
	if body.name == "Player":
		pass

func unpause(_timeline_name):
	get_tree().paused = false

func dialogic_signal(arguement):
	match arguement:
		'end_game':
			get_tree().paused = false
			get_tree().quit()
		'no':
			player.position += Vector2(pos_x, 0)

func toggle_enable():
	enabled = !enabled
