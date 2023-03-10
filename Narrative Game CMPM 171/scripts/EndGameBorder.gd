extends Node2D
# reusing this script to run the sequence for entering the switchboard room

export var xpos = 1376
export var ypos = 1168

onready var player = get_node("../Player")
onready var bobby = get_node("../NPCMobleader")
onready var _transition_rect = get_node("../TransitionBox/SceneTransitionRect")

var event_happened = false

# rolling
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Border_body_entered(body):
	if !event_happened and body.name == "Player":
		yield(_transition_rect._anim_player, "animation_finished")
		get_tree().paused = true
		var dialog = Dialogic.start("Inside Switchboard")
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		add_child(dialog)
		dialog.connect('timeline_end', self, 'unpause')
		dialog.connect('dialogic_signal', self, 'dialogic_signal')

func _on_Border_body_exited(body):
	if body.name == "Player":
		pass

func unpause(_timeline_name):
	get_tree().paused = false
	event_happened = true

func dialogic_signal(arguement):
	match arguement:
		'logic_roll':
			dice_roll("logic", (player.logic - 10) / 2)
			pass
		'dream_roll':
			dice_roll("dream", (player.dream - 10) / 2) 
			pass
		'empathy_roll':
			dice_roll("empathy", (player.empathy - 10) / 2)
			pass
		'perception_roll':
			dice_roll("perception", (player.perception - 10) / 2)
			pass
		'charisma_roll':
			dice_roll("charisma", (player.charisma - 10) / 2)
			pass
		'culture_roll':
			dice_roll("culture", (player.culture - 10) / 2)
			pass
		'composure_roll':
			dice_roll("composure", (player.composure - 10) / 2)
			pass
		'reflex_roll':
			dice_roll("reflex", (player.reflex - 10) / 2)
			pass
		'logic_set':
			set_val("logic", player.logic)
			pass
		'dream_set':
			set_val("dream", player.dream) 
			pass
		'empathy_set':
			set_val("empathy", player.empathy)
			pass
		'perception_set':
			set_val("perception", player.perception)
			pass
		'charisma_set':
			set_val("charisma", player.charisma)
			pass
		'culture_set':
			set_val("culture", player.culture)
			pass
		'composure_set':
			set_val("composure", player.composure)
			pass
		'reflex_set':
			set_val("reflex", player.reflex)
			pass
		'reposition_bobby':
			bobby.position.x = xpos + 96
			bobby.position.y = ypos
			pass
		'reset_bobby':
			bobby.position.x = xpos - 128
			bobby.position.y = ypos - 448
			pass

func dice_roll(type, bonus): # the universal dice roll check
#	print("Rolling for " + str(type))
	# roll dice
	rng.randomize()
	var roll1 = floor(rng.randf_range(1, 6))
	var roll2 = floor(rng.randf_range(1, 6))
	
	# resolve
	var sum = roll1 + roll2 + bonus
	print("Result: " + str(roll1) + " + " + str(roll2) + " + " + str(bonus) + " = " + str(sum))
	Dialogic.set_variable(type, sum)


func set_val(type, value): # the universal dialogic stat access
#	print("Seting stat for: " + str(type))
	print("Value = " + str(value))
	Dialogic.set_variable(type, value)
