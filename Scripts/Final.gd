extends Node2D

onready var request = get_node("HTTPRequest")
onready var parent = get_parent()

const SAVE_PATH = "user://secret.save"
var username
var publish
var error

# Called when the node enters the scene tree for the first time.
func _ready():
	$Public.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Public_pressed():
	$Public.disabled = true
	
	#get name
	username = $TextEdit.get_text()
	
	#getScore
	var scoreA = 1000 - parent.counter
	var score_id = yield(SilentWolf.Scores.persist_score(username, scoreA), "sw_score_posted")
	
	get_tree().change_scene("res://Cenas/TitleScreen/Interface.tscn")
	get_tree().paused = not get_tree().paused
	

func _on_Back_pressed():
	get_tree().change_scene("res://Cenas/TitleScreen/Interface.tscn")
	get_tree().paused = not get_tree().paused


func _input(event):
	if Input.is_action_just_pressed("backspace"):
		$TextEdit.readonly = false


func _on_TextEdit_text_changed():
	if $TextEdit.get_text().length() > 7:
		$TextEdit.readonly = true
