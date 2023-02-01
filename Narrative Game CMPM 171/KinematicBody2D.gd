extends KinematicBody2D

"""
Works Cited:
https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://staffwww.fullcoll.edu/dcraig/gameprog/godot%20lecture%202.pdf
"""

const GRAVITY = 10

export (int) var speed = 200

var velocity = Vector2()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
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

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))
