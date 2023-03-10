extends Area2D

"""
Works Cited:
https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
"""

# editable variables
export(NodePath) onready var target = get_node(target)
export var disabled = false

# interaction
onready var transition_rect = get_node("../../TransitionBox/SceneTransitionRect")
var isOverDoor := false
var player = null

# sound
onready var _audio_output := $AudioStreamPlayer2D 
var lockedSound = preload("res://assets/sound/Door_Locked_V1.wav")
var openSound = preload("res://assets/sound/Door_Open_V2.wav")
var slamSound = preload("res://assets/sound/Door_Slam_V1.wav")

func _on_Door_body_entered(body):
	player = body
	if body.name == 'Player':
		isOverDoor = true

func _on_Door_body_exited(body):
	if body.name == 'Player':
		isOverDoor = false

func _on_NearDoor_body_entered(body):
	if body.name == "Player" and !disabled:
		$AnimatedSprite.play("open")
		_audio_output.stop()
		_audio_output.stream = openSound
		_audio_output.play()

func _on_NearDoor_body_exited(body):
	if body.name == "Player" and !disabled:
		$AnimatedSprite.play("closed")
		_audio_output.stop()
		_audio_output.stream = slamSound
		_audio_output.play()

func _physics_process(_delta):
	$Icon.visible = isOverDoor
	if isOverDoor and Input.is_action_just_pressed("interact"):
		if !disabled: # door will allow player to enter through
			transition_rect.fade()
			player.position = target.position
			player.get_node("Camera2D").reset_smoothing()
			transition_rect.unfade()
		else: # player can touch the door knob and do nothing
			_audio_output.stop()
			_audio_output.stream = lockedSound
			_audio_output.play()
