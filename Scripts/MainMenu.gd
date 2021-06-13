extends Control

var volume_slider

var music = preload("res://Assets/Music/Game-Jam-June-2021-Menu.ogg")


func _play_game():
	SceneTransitions._fade_start(true)

func _ready():
	AudioPlayer._play_sound(music)
	volume_slider = $VolumeSlider
	volume_slider.value = AudioPlayer.volume

func _quit_game():
	get_tree().quit()

func _on_volume_changed(value):
	AudioPlayer.change_volume(value)
	
