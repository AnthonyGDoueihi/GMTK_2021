extends Control


func _ready():
	_unpause_game()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if !get_tree().paused:
			_pause_game()
		else:
			_unpause_game()

func _pause_game():
	get_tree().paused = true
	self.show()

func _unpause_game():
	get_tree().paused = false
	self.hide()

func _main_menu():
	_unpause_game()
	SceneTransitions._fade_start(false)
