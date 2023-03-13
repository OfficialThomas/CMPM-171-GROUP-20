extends ColorRect


#	Works Cited:
#	https://www.gdquest.com/tutorial/godot/2d/scene-transition-rect/


# Path to the next scene to transition to
export(String, FILE, "*.tscn") var next_scene_path

# Reference to the _AnimationPlayer_ node
onready var _anim_player := $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Plays the animation backward to fade in
	_anim_player.play_backwards("Fade")


func transition_to(_next_scene := next_scene_path) -> void:
	# Plays the Fade animation and wait until it finishes
	_anim_player.play("Fade")
	yield(_anim_player, "animation_finished")
	# Changes the scene
	get_tree().change_scene(_next_scene)

func fade() -> void:
	_anim_player.play("Fade")
	yield(_anim_player, "animation_finished")
	
func unfade() -> void:
	_anim_player.play_backwards("Fade")
