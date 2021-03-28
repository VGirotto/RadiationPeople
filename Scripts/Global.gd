extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
			  "api_key": "MUe7MIQlRZ8pO0ZLC7QmS9pNWbH7GsEd8YDyQ48l",
			  "game_id": "RadiationPeople",
			  "game_version": "1.0.0",
			  "log_level": 0
			})


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
