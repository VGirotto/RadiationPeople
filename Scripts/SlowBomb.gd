extends Area2D

onready var parent = get_parent()
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Area2D_body_entered(body):
	if body is KinematicBody2D:
		if !parent.putBomb:
			body.vel = 25


func _on_Timer_timeout():
	parent.slowBomb = true
	get_parent().remove_child(self)


func _on_Area2D_body_exited(body):
	if body is KinematicBody2D:
		body.vel = 40
