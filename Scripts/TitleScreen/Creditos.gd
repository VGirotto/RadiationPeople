extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Voltar_pressed():

	yield(SilentWolf.Scores.get_high_scores(50), "sw_scores_received")
	#for score in SilentWolf.Scores.scores:
	#	print("\t\t" + score["player_name"] + "\t\t" + String((1000 - score["score"])) + " " + score["score_id"])
	
	
	get_tree().change_scene("res://Cenas/TitleScreen/Interface.tscn")

