extends KinematicBody2D

export var vel = 40
var contamined = false
onready var parent = get_parent()
onready var timer = get_node("Timer")

var dir = Vector2.ZERO
var collision
var initDir
var change
var cure = true
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
		if !parent.putMed and cure:
			if body.contamined:
				#cure minion
				cure = false
				timer.start(5)
				parent.counter -= 1
				body.contamined = false
				body.get_node("CollisionShape2D/exclama").visible = false
				body.get_node("CollisionShape2D/Sprite").modulate = Color(float(randi()%100)/100, float(randi()%100)/100, float(randi()%100)/100, 1)
				if parent.medCounter == 1:
					parent.medButton.disabled = false


func _on_Timer_timeout():
	cure = true
