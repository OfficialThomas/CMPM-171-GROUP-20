extends Area2D

export(NodePath) onready var target = get_node(target)
var isOverDoor := false
var isLocked := true
var player


func _on_Door_body_entered(body):
	isOverDoor = true
	player = body


func _on_Door_body_exited(body):
	isOverDoor = false


func _on_NearDoor_body_entered(body):
	$AnimatedSprite.play("open")
	isLocked = false

func _physics_process(delta):
	if isOverDoor and Input.is_action_just_pressed("up"):
		player.position = target.position
		
