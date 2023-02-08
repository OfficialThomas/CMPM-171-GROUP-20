extends Control

"""
Works Cited:
https://youtu.be/oq_s5Ivg4Ow
"""

onready var player = get_node("../../Player")
onready var node_stat_points = get_node("HBoxContainer/VBoxContainer/Stats/MainStats/StatPoints/Label")
var path_main_stats = "HBoxContainer/VBoxContainer/Stats/MainStats/"

var available_points
var logic_add = 0
var dream_add = 0
var empathy_add = 0
var perception_add = 0
var charisma_add = 0
var culture_add = 0
var composure_add = 0

func _ready():
	LoadStats()
	available_points = player.stat_points
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
		
func LoadStats():
	get_node(path_main_stats + "Logic/StatBackground/Stats/Value").set_text(str(player.logic))
	get_node(path_main_stats + "Dream/StatBackground/Stats/Value").set_text(str(player.dream))
	get_node(path_main_stats + "Empathy/StatBackground/Stats/Value").set_text(str(player.empathy))
	get_node(path_main_stats + "Perception/StatBackground/Stats/Value").set_text(str(player.perception))
	get_node(path_main_stats + "Charisma/StatBackground/Stats/Value").set_text(str(player.charisma))
	get_node(path_main_stats + "Culture/StatBackground/Stats/Value").set_text(str(player.culture))
	get_node(path_main_stats + "Composure/StatBackground/Stats/Value").set_text(str(player.composure))
		
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


func _on_Confirm_pressed():
	if logic_add + dream_add + empathy_add + perception_add + charisma_add + culture_add + composure_add == 0:
		print("Nothing to confirm, add a pop-up here maybe?")
	else:
		player.stat_points = available_points
		player.logic += logic_add
		player.dream += dream_add
		player.empathy += empathy_add
		player.perception += perception_add
		player.charisma += charisma_add
		player.culture += culture_add
		player.composure += composure_add
		logic_add = 0
		dream_add = 0
		empathy_add = 0
		perception_add = 0
		charisma_add = 0
		culture_add = 0
		composure_add = 0
		LoadStats()
		for button in get_tree().get_nodes_in_group("MinButtons"):
			button.set_disabled(true)
		for label in get_tree().get_nodes_in_group("ChangeLabels"):
			label.set_text("")

func _on_Stats_pressed(): # set to stats menu
	get_node("HBoxContainer/VBoxContainer/Stats").show()
	get_node("HBoxContainer/VBoxContainer/Exit").hide()

func _on_Exit_pressed(): # set to exit menu
	get_node("HBoxContainer/VBoxContainer/Exit").show()
	get_node("HBoxContainer/VBoxContainer/Stats").hide()
