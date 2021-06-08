extends Control

var count = 0

onready var game_timer = get_node("GameTimeTimer")
onready var game_pb = get_node("GamePB")
onready var game_label = get_node("GameTimeLabel")
onready var card_art = get_node("CardArt")
onready var card_text = get_node("MarginContainer1/VBoxContainer/CardText")
onready var card_title = get_node("MarginContainer1/VBoxContainer/CardTitle")
onready var sprite_array = [get_node("MarginContainer1/VBoxContainer/HBoxContainer/TextureRect/TextureRect"),
get_node("MarginContainer1/VBoxContainer/HBoxContainer/TextureRect2/TextureRect"),
get_node("MarginContainer1/VBoxContainer/HBoxContainer/TextureRect3/TextureRect"),
get_node("MarginContainer1/VBoxContainer/HBoxContainer/TextureRect4/TextureRect") ]


# Called when the node enters the scene tree for the first time.
func _ready():
	game_timer.wait_time = game_pb.value
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	game_pb.value = game_timer.time_left
	var time = time_func(game_pb.value)
	game_label.set_text(time)

#convert seconds into --> mm:ss
func time_func(s):
	var time_s = int(s)
	var time_m = 0
	while time_s > 60:
		time_m += 1
		time_s -= 60
	var results = ""
	if time_m > 0:
		results += str(time_m)
	else:
		results += "0"
	results += ":"
	if time_s >= 10:
		results += str(time_s)
	else:
		results += "0" + str(time_s)
	return results						


#functionality for Travel-button
#prints CardArt & CardText
func _on_TravelButton_pressed():
	#text 
	var file = File.new()
	file.open("res://texts/data.json", file.READ)
	var json = file.get_as_text()
	var json_results = JSON.parse(json).result
	file.close()
	
	var biomeCount = int(json_results["Sheet1"][0]["BiomCount"])
	activate_biomes(biomeCount)
	card_title.set_text(json_results["Sheet1"][0]["Name"])
	card_text.set_text(json_results["Sheet1"][0]["Effect"])
	#art


#kuvat arrayhyn	
func list_images(path):
	var images = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var img = dir.get_next()
		if img == "":
			break
		elif img.ends_with("png"):
			images.append(img)
	return images	

func activate_biomes(countB):
	var b = rand_range(1,countB)
	

func shuffle_array(arr):
	pass

#functionality for BiomeButton
func _on_BiomeButton_pressed():
	pass
