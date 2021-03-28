extends Control

const SAVE_PATH = "res://save.json"

var scene_path_to_load
var nome_botao
var save_file = File.new()

func _ready():
	if !Sot.get_node("/root/Sot").is_playing():
		Sot.get_node("/root/Sot").play()
	for button in $Menu/HBoxContainer/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load, button.botao])
	

func _on_Button_pressed(scene_to_load, botao):
	scene_path_to_load = scene_to_load
	nome_botao = botao
	
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene_path_to_load)
	

func _on_sot_finished():
	$sot.play()
