extends Control

"""
Works Cited:
https://youtu.be/0TZ2U8eUskA
https://youtu.be/oq_s5Ivg4Ow
https://youtu.be/nskVFc3tJgY
https://www.reddit.com/r/godot/comments/cjigi4/how_do_i_make_hitting_the_esc_key_exit_the_game/
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
var reflex_add = 0

func _ready():
	LoadStats()
	LoadBonuses()
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
	get_node(path_main_stats + "Reflex/StatBackground/Stats/Value").set_text(str(player.reflex))


func LoadBonuses():
	get_node(path_main_stats + "Logic/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.logic - 10) / 2))
	get_node(path_main_stats + "Dream/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.dream - 10) / 2))
	get_node(path_main_stats + "Empathy/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.empathy - 10) / 2))
	get_node(path_main_stats + "Perception/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.perception - 10) / 2))
	get_node(path_main_stats + "Charisma/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.charisma - 10) / 2))
	get_node(path_main_stats + "Culture/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.culture - 10) / 2))
	get_node(path_main_stats + "Composure/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.composure - 10) / 2))
	get_node(path_main_stats + "Reflex/StatBackground/Stats/Bonus").set_text("Bonus:" + "+" + str((player.reflex - 10) / 2))


func IncreaseStat(stat):
	print(stat + " Increase")
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
	if logic_add + dream_add + empathy_add + perception_add + charisma_add + culture_add + composure_add + reflex_add == 0:
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
		player.reflex += reflex_add
		logic_add = 0
		dream_add = 0
		empathy_add = 0
		perception_add = 0
		charisma_add = 0
		culture_add = 0
		composure_add = 0
		reflex_add = 0
		LoadStats()
		LoadBonuses()
		for button in get_tree().get_nodes_in_group("MinButtons"):
			button.set_disabled(true)
		for label in get_tree().get_nodes_in_group("ChangeLabels"):
			label.set_text("")


func _on_Stats_pressed(): # set to stats menu
	print("Stats Button")
	get_node("HBoxContainer/VBoxContainer/Stats").show()
	get_node("HBoxContainer/VBoxContainer/Save").hide()
	get_node("HBoxContainer/VBoxContainer/System").hide()
	get_node("HBoxContainer/VBoxContainer/Exit").hide()


func _on_Save_pressed(): # set to save menu
	print("Save Button")
	get_node("HBoxContainer/VBoxContainer/Stats").hide()
	get_node("HBoxContainer/VBoxContainer/Save").show()
	get_node("HBoxContainer/VBoxContainer/System").hide()
	get_node("HBoxContainer/VBoxContainer/Exit").hide()


func _on_System_pressed(): # set to system menu
	print("System Button")
	get_node("HBoxContainer/VBoxContainer/Stats").hide()
	get_node("HBoxContainer/VBoxContainer/Save").hide()
	get_node("HBoxContainer/VBoxContainer/System").show()
	get_node("HBoxContainer/VBoxContainer/Exit").hide()


func _on_Exit_pressed(): # set to exit menu
	print("Exit Button")
	get_node("HBoxContainer/VBoxContainer/Stats").hide()
	get_node("HBoxContainer/VBoxContainer/Save").hide()
	get_node("HBoxContainer/VBoxContainer/System").hide()
	get_node("HBoxContainer/VBoxContainer/Exit").show()


func _on_ExitAndSave_pressed(): # save game and exit game
	# TODO: add save function here (saves to quicksave)
	get_tree().quit()

func _on_ExitNoSave_pressed(): # exit game
	get_tree().quit()

