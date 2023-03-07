extends Area2D

var active = false
onready var player = get_node("../Player")
# rolling
var rng = RandomNumberGenerator.new()

# the 2d list of dialogue
var d_default = ["Test"]
var d_guide = ["Guide"]
var d_start = ["Opening"]
var d_brother = ["Meeting Brother"]
var d_worker = ["Meeting Worker"]
var d_manager = ["Meeting Manager"]
var d_outside = ["Outside Switchboard"]
var d_inside = ["Inside Switchboard"]
var d_investigate = ["Investigating Switchboard"]
onready var d_events = [d_default, d_guide, d_start, d_brother, d_worker, d_manager, d_outside, d_inside, d_investigate]

export (int) var pos_x = 0
export (int) var pos_y = 0

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')


func _process(_delta):
	$AnimatedSprite.play("idle")
	$Icon.visible = active
	if Input.is_action_pressed("interact"):
		if get_node_or_null('DialogNode') == null:
#			re-add these lines when internal testing
#			print(dMember)
#			print(dMember.d_events[dMember.pos_y][dMember.pos_x])
			if active:
				get_tree().paused = true
				var dialog = Dialogic.start(d_events[pos_y][pos_x])
				dialog.pause_mode = Node.PAUSE_MODE_PROCESS
				add_child(dialog)
				dialog.connect('timeline_end', self, 'unpause')
				dialog.connect('dialogic_signal', self, 'dialogic_signal')


func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false

func unpause(_timeline_name):
	get_tree().paused = false

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
