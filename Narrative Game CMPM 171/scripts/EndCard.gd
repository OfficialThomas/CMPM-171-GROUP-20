extends Node2D


#scene transition
onready var _transition_rect := $GUI/SceneTransitionRect
export(String, FILE, "*.tscn") var next_scene_path

# rolling
var rng = RandomNumberGenerator.new()

#BGM
onready var _audio_output := $AudioStreamPlayer2D 
var dreamBGM = preload("res://assets/Music/dream_sequence.mp3")

func _ready():
	_audio_output.stop()
	_audio_output.stream = dreamBGM
	_audio_output.play()

func start_game():
	_transition_rect.transition_to("res://play-scenes/Intro.tscn")
