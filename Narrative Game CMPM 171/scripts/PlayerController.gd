extends KinematicBody2D

#	Works Cited:
#	https://www.gdquest.com/tutorial/godot/2d/scene-transition-rect/
#	https://docs.godotengine.org/en/stable/tutorials/2d/2d_movement.html
#	chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://staffwww.fullcoll.edu/dcraig/gameprog/godot%20lecture%202.pdf
#	https://godotengine.org/qa/72089/how-do-i-play-animation-using-gdscript
#	https://godotengine.org/qa/3953/want-flip-character-the-horizontal-axis-but-whats-the-best-way
#	https://godotengine.org/qa/88590/correct-way-to-load-and-play-sounds-from-code

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

# movement
const GRAVITY = 10
export (int) var speed = 200
var velocity = Vector2()

# audio sfx
onready var _sfx_output := $SFXPlayer
onready var _bgm_output := $BGMPlayer
var walkSound = preload("res://assets/sound/Walking_V3.wav")
var squishSound = preload("res://assets/sound/Walking_Squish_V2.wav")
var startBGM = preload("res://assets/sound/Machines_V2.wav")
var walking = false

func _ready():
	if !_sfx_output.is_playing():
		_bgm_output.stream = startBGM
		_bgm_output.play()

func get_input():
	# movement input
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
		$AnimatedSprite.play("playerWalkRight")
		walking = true
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		$AnimatedSprite.play("PlayerWalkLeft")
		walking = true
	else:
		$AnimatedSprite.play("playerIdle")
		_sfx_output.stop()
		walking = false
#	Kept this just for completedness of input tests
#	if Input.is_action_pressed("down"):
#		velocity.y += 1
#	if Input.is_action_pressed("up"):
#		velocity.y -= 1
	
	if walking:
		if !_sfx_output.is_playing():
			_sfx_output.stream = walkSound
			_sfx_output.play()
	
	# positive is down in a 2d canvas space
	velocity.y += GRAVITY
	if is_on_floor():
		velocity.y = 0
	# must normalize velocity so player moves smoothly
	velocity = velocity.normalized() * speed


func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity, Vector2(0, -1))


func level_up():
	stat_points += 3


func unpause(_timeline_name):
	get_tree().paused = false
