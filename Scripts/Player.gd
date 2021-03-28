extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dir = Vector2.ZERO
var move
var vel = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move
	move = dir * vel
	move_and_collide(move)

func _input(ev):
	if Input.is_key_pressed(KEY_RIGHT):
		dir.x = 1
	elif Input.is_key_pressed(KEY_LEFT):
		dir.x = -1
	else:
		dir.x = 0
	
	if Input.is_key_pressed(KEY_UP):
		dir.y = -1
	elif Input.is_key_pressed(KEY_DOWN):
		dir.y = 1
	else:
		dir.y = 0
