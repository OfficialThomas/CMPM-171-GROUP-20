extends KinematicBody2D

"""
Works Cited:
https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://staffwww.fullcoll.edu/dcraig/gameprog/godot%20lecture%202.pdf
https://godotengine.org/qa/72089/how-do-i-play-animation-using-gdscript
https://godotengine.org/qa/3953/want-flip-character-the-horizontal-axis-but-whats-the-best-way
"""


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
		$AnimatedSprite.set_flip_h(false)
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		$AnimatedSprite.set_flip_h(true)
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	"""
	Kept this just for completedness of input tests
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	"""
	
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
				print(dMember)
				print(get_node(dMember).get("d_events")) # error - im trying to find out how to access the string from the tutorial guide
				if dMember.active:
					get_tree().paused = true
					var dialog = Dialogic.start(dMember.d_events[dMember.xpos][dMember.ypos])
					dialog.pause_mode = Node.PAUSE_MODE_PROCESS
					dialog.connect('timeline_end', self, 'unpause')
					add_child(dialog)

func _physics_process(_delta):
	
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
func LevelUp():
	stat_points += 5

func ComposureRoll():
	rng.randomize()
	var roll = floor(rng.randf_range(0, 13)) + (composure - 10) / 2

func unpause(timeline_name):
	get_tree().paused = false
