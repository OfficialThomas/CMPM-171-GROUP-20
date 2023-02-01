extends KinematicBody2D

# https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html

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
	Kept this just for completedness - input tests
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	"""
	
	# positive is down in a 2d canvas space
	velocity.y += GRAVITY
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
