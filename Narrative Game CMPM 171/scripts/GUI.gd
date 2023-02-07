extends CanvasLayer

"""
Works Cited:
https://youtu.be/oq_s5Ivg4Ow
"""

func _input(event):
	if event.is_action_pressed("MenuScreen"):
		if not has_node("CharacterSheet"):
			var character_sheet = load("res://assets/game-objects/gui-system/CharacterSheet.tscn").instance()
			add_child(character_sheet)
		else:
			get_node("CharacterSheet").queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
