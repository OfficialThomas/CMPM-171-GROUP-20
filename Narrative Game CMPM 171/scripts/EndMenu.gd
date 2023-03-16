extends Control


onready var gui = get_node("../../GUI")
onready var world = get_node("../../")
onready var _audio_output := $AudioStreamPlayer2D 
var buttonSound = preload("res://assets/sound/Button_Press_V1.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Start_pressed():
	_audio_output.stop()
	_audio_output.stream = buttonSound
	_audio_output.play()
	yield(_audio_output, "finished")
	world.start_game()


func _on_Credits_pressed():
	_audio_output.stop()
	_audio_output.stream = buttonSound
	_audio_output.play()
	get_node("MenuScreen").hide()
	get_node("Credits").show()


func _on_ExitGame_pressed():
	_audio_output.stop()
	_audio_output.stream = buttonSound
	_audio_output.play()
	yield(_audio_output, "finished")
	get_tree().quit()


func _on_ReturnFCredits_pressed():
	_audio_output.stop()
	_audio_output.stream = buttonSound
	_audio_output.play()
	get_node("MenuScreen").show()
	get_node("Credits").hide()
