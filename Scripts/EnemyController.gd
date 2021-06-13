extends Node2D

onready var minion = preload("res://Nodes/Units/T1_Bad_Minion.tscn")
onready var warrior = preload("res://Nodes/Units/T2_Bad_Warrior.tscn")
onready var lord_mint = preload("res://Nodes/Units/T3_Bad_Lord_Mint.tscn")

var minions = []
var warriors = []
var lord_mints = []
var queen
var camera

var timer

var resources = 100

var priority
enum {
	BUILD,
	PROTECT,
	ATTACK
}

var priority_int
var game_over = false
func _ready():
	camera = get_tree().get_nodes_in_group("Camera")[0]
	timer = $Timer
	queen = get_tree().get_nodes_in_group("EvilQueen")[0]
	lord_mints = get_tree().get_nodes_in_group("EvilMints")
	warriors = get_tree().get_nodes_in_group("EvilWarriors")
	minions = get_tree().get_nodes_in_group("EvilMinions")
	set_lord_mints()
	pick_priority()

func _process(delta):
	resources += lord_mints.size() * 3 * delta
	if priority == BUILD:
		if lord_mints.size() < 2:
			build_lord_mint()
		else:
			if priority_int < 3 and not lord_mints.size() > 5:
				build_lord_mint()
			elif priority_int < 5:
				build_warrior()
			else:
				build_minion()
	elif priority == PROTECT:
		if priority_int < 7:
			build_warrior()
		else:
			build_minion()
	elif priority == ATTACK:
		if priority_int < 4:
			build_warrior()
		else:
			build_minion()

	check_dead()
	
func check_dead():
	if queen.is_dead and not game_over:
		game_over = true
		camera.victory()
		return 
	for w in warriors:
		if w and w.is_dead:
			warriors.erase(w)
			w.queue_free()
	for m in minions:
		if m and m.is_dead:
			minions.erase(m)
			m.queue_free()
	for lm in lord_mints:
		if lm and lm.is_dead:
			lord_mints.erase(lm)
			lm.queue_free()
				
func pick_priority():
	randomize()
	timer.wait_time = rand_range(1.0, 30.0)
	priority_int = int(round(rand_range(1, 10)))

	if lord_mints.size() < 2:
		priority = BUILD
	elif (warriors.size() + minions.size()) > 10 or priority_int == 10:
		priority = ATTACK
		for i in range(1, lord_mints.size()):
			lord_mints[i].target_position = Vector2(-850, 200)
	elif resources < 10 or priority_int == 1:
		priority = BUILD
	else:
		priority = PROTECT
		for i in range(1, lord_mints.size()):
			lord_mints[i].target_position = Vector2(900, 200)
			
	timer.start()

func set_lord_mints():
	for w in warriors:
		w.lord_mints = lord_mints
	for m in minions:
		m.lord_mints = lord_mints 

func build_minion():
	if resources > 10:
		resources -= 10
		var new_minion = minion.instance()
		new_minion.lord_mints = lord_mints
		new_minion.position = Vector2(900, 200)
		minions.append(new_minion)
		add_child(new_minion)
	
func build_warrior():
	if resources > 50:
		resources -= 50
		var new_warrior = warrior.instance()
		new_warrior.lord_mints = lord_mints
		new_warrior.position = Vector2(900, 200)
		warriors.append(new_warrior)
		add_child(new_warrior)
	
func build_lord_mint():
	if resources > 100:
		resources -= 100
		var new_lord_mint = lord_mint.instance()
		new_lord_mint.position = Vector2(900, 200)
		lord_mints.append(new_lord_mint)
		add_child(new_lord_mint)
		set_lord_mints()
