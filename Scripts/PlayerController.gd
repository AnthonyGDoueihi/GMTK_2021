extends Node2D

var selected_unit

onready var minion = preload("res://Nodes/Units/T1_Good_Minion.tscn")
onready var warrior = preload("res://Nodes/Units/T2_Good_Warrior.tscn")
onready var lord_mint = preload("res://Nodes/Units/T3_Good_Lord_Mint.tscn")

var unit_array = []
var lord_mints = []
var warriors = []
var minions = []
var queen
var camera
var resources = 1000

var keycodes = [49, 50, 51, 52, 53, 54, 55, 56, 57] 

func _ready():
	camera = get_tree().get_nodes_in_group("Camera")[0]
	queen = get_tree().get_nodes_in_group("PlayerQueen")[0]
	unit_array.append(queen)
	selected_unit = queen
	lord_mints = get_tree().get_nodes_in_group("PlayerMints")
	warriors = get_tree().get_nodes_in_group("PlayerWarriors")
	minions = get_tree().get_nodes_in_group("PlayerMinions")
	unit_array += lord_mints
	set_lord_mints()
		
func _process(delta):
	for i in range(0, unit_array.size()):
		if Input.is_key_pressed(keycodes[i]):
			selected_unit.deselect()
			selected_unit = unit_array[i]
			selected_unit.select()
	
	resources += lord_mints.size() * 0.5 * delta

	if Input.is_action_pressed("snap"):
		camera.snap_to(selected_unit.position.x)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if selected_unit != queen:
			selected_unit.target_position = get_global_mouse_position()

func set_lord_mints():
	for w in warriors:
		w.lord_mints = lord_mints
	for m in minions:
		m.lord_mints = lord_mints 

func build_minion():
	if resources > 100:
		resources -= 100
		var new_minion = minion.instance()
		new_minion.lord_mints = lord_mints
		new_minion.position = Vector2(-900, 200)
		minions.append(new_minion)
		add_child(new_minion)
	
func build_warrior():
	if resources > 500:
		resources -= 500
		var new_warrior = warrior.instance()
		new_warrior.lord_mints = lord_mints
		new_warrior.position = Vector2(-900, 200)
		warriors.append(new_warrior)
		add_child(new_warrior)
	
func build_lord_mint():
	if resources > 1000:
		resources -= 1000
		var new_lord_mint = lord_mint.instance()
		new_lord_mint.position = Vector2(-900, 200)
		lord_mints.append(new_lord_mint)
		unit_array.append(new_lord_mint)
		add_child(new_lord_mint)
		set_lord_mints()

