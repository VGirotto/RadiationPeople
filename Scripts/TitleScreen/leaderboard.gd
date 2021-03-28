extends Node2D

onready var ranking = get_node("ranking")

func _ready():
	
#	var error = $HTTPRequest.request("http://galfar.dyndns.org:25577/")
#	print("Leaderboard error: " + String(error))

	yield(SilentWolf.Scores.get_high_scores(), "sw_scores_received")
	
	var text = " Pos\t\tName\t\tScore\n"
	var i = 1
	for score in SilentWolf.Scores.scores:
		text += String(i) + "\t\t" + score["player_name"] + "\t\t" + String((1000 - score["score"])) + "\n"
		i += 1

	ranking.set_text(text)

func _on_Voltar_pressed():
	get_tree().change_scene("res://Cenas/TitleScreen/Interface.tscn")


#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
#	var data = JSON.parse(body.get_string_from_utf8())
#	data = data.result["RadiationPeople"]
#
#	var rank = []
#	var dic = {}
#
#	# get best results
#	for username in data:
#		dic["user"] = username
#		dic["score"] = data[username]["Highscore"]
#		rank.append(dic)
#		dic = {}
#
#
#	rank.sort_custom(MyCustomSorter, "sort")
	
#	var text = " Pos\t\tName\t\tScore\n"
#	text += " 1  \t\t" + rank[0]["user"] + "\t\t" + String(rank[0]["score"]) + "\n"
#	text += " 2  \t\t" + rank[1]["user"] + "\t\t" + String(rank[1]["score"]) + "\n"
#	text += " 3  \t\t" + rank[2]["user"] + "\t\t" + String(rank[2]["score"]) + "\n"
#	text += " 4  \t\t" + rank[3]["user"] + "\t\t" + String(rank[3]["score"]) + "\n"
#	text += " 5  \t\t" + rank[4]["user"] + "\t\t" + String(rank[4]["score"]) + "\n"
#
#	ranking.set_text(text)

#class MyCustomSorter:
#	static func sort(a, b):
#		if a["score"] < b["score"]:
#			return true
#		return false
