extends Control


onready var gui = get_node("../../GUI")
onready var world = get_node("../../")
var introScript;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Start_pressed():
	world.start_game()
	gui.get_node("IntroMenu").queue_free()


func _on_Guide_pressed():
	get_node("MenuScreen").hide()
	get_node("Guide").show()
	get_node("Credits").hide()


func _on_Credits_pressed():
	get_node("MenuScreen").hide()
	get_node("Guide").hide()
	get_node("Credits").show()


func _on_ExitGame_pressed():
	get_tree().quit()


func _on_ReturnFGuide_pressed():
	get_node("MenuScreen").show()
	get_node("Guide").hide()
	get_node("Credits").hide()


func _on_ReturnFCredits_pressed():
	get_node("MenuScreen").show()
	get_node("Guide").hide()
	get_node("Credits").hide()
