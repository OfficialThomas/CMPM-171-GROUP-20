extends Control

"""
Works Cited:
https://youtu.be/oq_s5Ivg4Ow
"""

onready var node_stat_points = get_node("HBoxContainer/VBoxContainer/Stats/MainStats/StatPoints/Label")
var path_main_stats = "HBoxContainer/VBoxContainer/Stats/MainStats/"

var available_points = 5
var logic_add = 0
var dream_add = 0
var empathy_add = 0
var perception_add = 0
var charisma_add = 0
var culture_add = 0
var composure_add = 0

func _ready():
	node_stat_points.set_text(str(available_points) + " Points")
	if available_points == 0:
		pass
	else:
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(false)
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.connect("pressed", self, "IncreaseStat", [button.get_node("../..").get_name()])
	for button in get_tree().get_nodes_in_group("MinButtons"):
		button.connect("pressed", self, "DecreaseStat", [button.get_node("../..").get_name()])
		
func IncreaseStat(stat):
	set(stat.to_lower() + "_add", get(stat.to_lower() + "_add") + 1) #Increase the stat_add (code)
	get_node(path_main_stats + stat + "/StatBackground/Stats/Change").set_text(
		"+" + str(get(stat.to_lower() + "_add")) + " ") #Update the change label (visual feedback)
	get_node(path_main_stats + stat + "/StatBackground/Min").set_disabled(false) #Unlock the minus button
	available_points -= 1 #Reduce the avaiable stat points (code)
	node_stat_points.set_text(str(available_points) + " Points") #Update the available stat points label (visual feedback)
	if available_points == 0:
		for button in get_tree().get_nodes_in_group("PlusButtons"):
			button.set_disabled(true) #If available points = 0, lock all plus buttons
	
func DecreaseStat(stat):
	set(stat.to_lower() + "_add", get(stat.to_lower() + "_add") - 1)
	if get(stat.to_lower() + "_add") == 0:
		get_node(path_main_stats + stat + "/StatBackground/Min").set_disabled(true)
		get_node(path_main_stats + stat + "/StatBackground/Stats/Change").set_text("")
	else:
		get_node(path_main_stats + stat + "/StatBackground/Stats/Change").set_text(
			"+" + str(get(stat.to_lower() + "_add")) + " ")
	available_points += 1
	node_stat_points.set_text(str(available_points) + " Points")
	for button in get_tree().get_nodes_in_group("PlusButtons"):
		button.set_disabled(false)
