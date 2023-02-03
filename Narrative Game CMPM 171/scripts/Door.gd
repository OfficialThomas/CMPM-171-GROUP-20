extends Area2D

"""
Works Cited:
https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html
"""

export(NodePath) onready var target = get_node(target)
var isOverDoor := false
var isLocked := true
var player = null

func _on_Door_body_entered(body):
	isOverDoor = true
	player = body

func _on_Door_body_exited(body):
	isOverDoor = false

func _on_NearDoor_body_entered(body):
	if (body.name == "Player"):
		$AnimatedSprite.play("open")
		isLocked = false
		
func _on_NearDoor_body_exited(body):
	if (body.name == "Player"):
		$AnimatedSprite.play("closed")
		isLocked = true

func _physics_process(delta):
	if isOverDoor and Input.is_action_just_pressed("up"):
		player.position = target.position
