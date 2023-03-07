extends Node2D


#	Works Cited:
#	https://www.gdquest.com/tutorial/godot/2d/scene-transition-rect/
#	https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
#	chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://staffwww.fullcoll.edu/dcraig/gameprog/godot%20lecture%202.pdf
#	https://godotengine.org/qa/72089/how-do-i-play-animation-using-gdscript
#	https://godotengine.org/qa/3953/want-flip-character-the-horizontal-axis-but-whats-the-best-way


#scene transition
onready var _transition_rect := $GUI/SceneTransitionRect
export(String, FILE, "*.tscn") var next_scene_path

# rolling
var rng = RandomNumberGenerator.new()

func start_game():
	var dialog = Dialogic.start("Opening")
	dialog.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(dialog)
	dialog.connect('timeline_end', self, 'unpause')
	dialog.connect('dialogic_signal', self, 'dialogic_signal')


func unpause(_timeline_name):
	#TO DO  - Add transition when we end the dialogue
	_transition_rect.transition_to("res://play-scenes/FinalMap.tscn")


func dialogic_signal(arguement):
	match arguement:
		'logic_roll':
			dice_roll("logic")
			pass
		'dream_roll':
			dice_roll("dream") 
			pass
		'empathy_roll':
			dice_roll("empathy")
			pass
		'perception_roll':
			dice_roll("perception")
			pass
		'charisma_roll':
			dice_roll("charisma")
			pass
		'culture_roll':
			dice_roll("culture")
			pass
		'composure_roll':
			dice_roll("composure")
			pass
		'reflex_roll':
			dice_roll("reflex")
			pass
		'logic_set':
			set_val("logic")
			pass
		'dream_set':
			set_val("dream") 
			pass
		'empathy_set':
			set_val("empathy")
			pass
		'perception_set':
			set_val("perception")
			pass
		'charisma_set':
			set_val("charisma")
			pass
		'culture_set':
			set_val("culture")
			pass
		'composure_set':
			set_val("composure")
			pass
		'reflex_set':
			set_val("reflex")
			pass


func dice_roll(type): # dice roll check without the player
#	print("Rolling for " + str(type))
	# roll dice
	rng.randomize()
	var roll1 = floor(rng.randf_range(1, 6))
	var roll2 = floor(rng.randf_range(1, 6))
	
	# resolve
	var sum = roll1 + roll2 + 0
#	print("Result: " + str(roll1) + " + " + str(roll2) + " + " + str(bonus) + " = " + str(sum))
	Dialogic.set_variable(type, sum)


func set_val(type): # stat access without using the player
#	print("Seting stat for: " + str(type))
#	print("Value = " + str(value))
	Dialogic.set_variable(type, 10) 
