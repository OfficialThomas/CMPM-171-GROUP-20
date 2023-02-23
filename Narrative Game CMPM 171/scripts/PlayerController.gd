extends KinematicBody2D


#	Works Cited:
#	https://www.gdquest.com/tutorial/godot/2d/scene-transition-rect/
#	https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
#	chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://staffwww.fullcoll.edu/dcraig/gameprog/godot%20lecture%202.pdf
#	https://godotengine.org/qa/72089/how-do-i-play-animation-using-gdscript
#	https://godotengine.org/qa/3953/want-flip-character-the-horizontal-axis-but-whats-the-best-way



# stats
var stat_points = 9
var logic = 10
var dream = 10
var empathy = 10
var perception = 10
var charisma = 10
var culture = 10
var composure = 10
var reflex = 10

# rolling
var rng = RandomNumberGenerator.new()

# movement
const GRAVITY = 10
export (int) var speed = 200
var velocity = Vector2()

func get_input():
	# movement input
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$AnimatedSprite.play("playerWalkRight")
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		$AnimatedSprite.play("PlayerWalkLeft")
	else:
		$AnimatedSprite.play("playerIdle")
#	Kept this just for completedness of input tests
#	if Input.is_action_pressed("down"):
#		velocity.y += 1
#	if Input.is_action_pressed("up"):
#		velocity.y -= 1
	
	# positive is down in a 2d canvas space
	velocity.y += GRAVITY
	if is_on_floor():
		velocity.y = 0
	# must normalize velocity so player moves smoothly
	velocity = velocity.normalized() * speed
	
	# interact input
	if Input.is_action_pressed("interact"):
		if get_node_or_null('DialogNode') == null:
			for dMember in get_tree().get_nodes_in_group("Dialogic Event"):
#				re-add these lines when internal testing
#				print(dMember)
#				print(dMember.d_events[dMember.pos_y][dMember.pos_x])
				if dMember.active:
					get_tree().paused = true
					var dialog = Dialogic.start(dMember.d_events[dMember.pos_y][dMember.pos_x])
					dialog.pause_mode = Node.PAUSE_MODE_PROCESS
					add_child(dialog)
					dialog.connect('timeline_end', self, 'unpause')
					dialog.connect('dialogic_signal', self, 'dialogic_signal')


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))


func level_up():
	stat_points += 5


func dialogic_signal(arguement):
	match arguement:
		'logic_roll':
			dice_roll("logic", (logic - 10) / 2)
			pass
		'dream_roll':
			dice_roll("dream", (dream - 10) / 2) 
			pass
		'empathy_roll':
			dice_roll("empathy", (empathy - 10) / 2)
			pass
		'perception_roll':
			dice_roll("perception", (perception - 10) / 2)
			pass
		'charisma_roll':
			dice_roll("charisma", (charisma - 10) / 2)
			pass
		'culture_roll':
			dice_roll("culture", (culture - 10) / 2)
			pass
		'composure_roll':
			dice_roll("composure", (composure - 10) / 2)
			pass
		'reflex_roll':
			dice_roll("reflex", (reflex - 10) / 2)
			pass
		'logic_set':
			set_val("logic", logic)
			pass
		'dream_set':
			set_val("dream", dream) 
			pass
		'empathy_set':
			set_val("empathy", empathy)
			pass
		'perception_set':
			set_val("perception", perception)
			pass
		'charisma_set':
			set_val("charisma", charisma)
			pass
		'culture_set':
			set_val("culture", culture)
			pass
		'composure_set':
			set_val("composure", composure)
			pass
		'reflex_set':
			set_val("reflex", reflex)
			pass


func dice_roll(type, bonus): # the universal dice roll check
#	print("Rolling for " + str(type))
	# roll dice
	rng.randomize()
	var roll1 = floor(rng.randf_range(1, 6))
	var roll2 = floor(rng.randf_range(1, 6))
	
	# resolve
	var sum = roll1 + roll2 + bonus
#	print("Result: " + str(roll1) + " + " + str(roll2) + " + " + str(bonus) + " = " + str(sum))
	Dialogic.set_variable(type, sum)


func set_val(type, value): # the universal dialogic stat access
#	print("Seting stat for: " + str(type))
#	print("Value = " + str(value))
	Dialogic.set_variable(type, value) 


func unpause(_timeline_name):
	get_tree().paused = false
