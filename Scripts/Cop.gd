extends KinematicBody2D

export var vel = 40
var contamined = false
onready var parent = get_parent()

var dir = Vector2.ZERO
var collision
var initDir
var change
var attack = true
var countAttack = 0

func get_dir(list):
	randomize()
	initDir = list[randi() % list.size()]
	match initDir:
		"down":
			dir = Vector2(0, 1) #down
		"up":
			dir = Vector2(0, -1) #up
		"right":
			dir = Vector2(1, 0) # right
		"left":
			dir = Vector2(-1, 0) # left

# Called when the node enters the scene tree for the first time.
func _ready():
	change = false
	#initial direction
	get_dir(["right", "up", "down", "left"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# move
	collision = move_and_collide(dir * vel * delta)
	if collision:
		get_dir(["right", "up", "down", "left"])
	if (position.y > 466 and position.y < 470) and (position.x > 85 and position.x < 120):
		if change == false:
			get_dir(["right", "up", "down"])
			change = true
	elif (position.y > 129 and position.y < 131) and (position.x > 417 and position.x < 448):
		if change == false:
			get_dir(["left", "up", "down"])
			change = true
	elif (position.y > 655 and position.y < 675) and (position.x > 663 and position.x < 667):
		if change == false:
			get_dir(["left", "up", "right"])
			change = true
	elif (position.y > 220 and position.y < 240) and (position.x > 965 and position.x < 967):
		if change == false:
			get_dir(["left", "up", "right"])
			change = true
	else:
		change = false


func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if !parent.putCop:
			if !attack:
				if body.contamined and !contamined:
					parent.copButton.disabled = false
					parent.counter += 1
					contamined = true
					get_node("CollisionShape2D/exclama").visible = true
					get_node("CollisionShape2D/Sprite").modulate = Color(0.19, 0.96, 0, 1)
			else:
				if body.contamined:
					#kill minion
					parent.get_node("Songs/shot").play()
					countAttack += 1
					parent.remove_child(body)
					parent.counter -= 1
					if countAttack == 3:
						attack = false
