extends CanvasLayer

var player

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]

func build_minion():
	player.build_minion()
	
func build_warrior():
	player.build_warrior()
	
func build_lord_mint():
	player.build_lord_mint()

func _process(delta):
	$Control/QueensEggs.text = String(round(player.resources))



