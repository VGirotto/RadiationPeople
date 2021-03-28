extends Control

onready var button = get_node("Button")
onready var timer = get_node("Timer")

var door
export var doorNum = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	# close the door
	button.disabled = true
	door = get_parent().get_node("door" + String(doorNum))
	get_parent().get_parent().get_node("Songs/door").play()
	
	if doorNum in [1, 2]:
		door.position.y += 40
	elif doorNum in [3, 4, 5]:
		door.position.y -= 40
	else:
		door.position.x += 40
	
	# timer for open the door
	timer.start(5)

func _on_Timer_timeout():
	if timer.is_stopped():
		door = get_parent().get_node("door" + String(doorNum))
		if doorNum in [1, 2]:
			door.position.y -= 40
		elif doorNum in [3, 4, 5]:
			door.position.y += 40
		else:
			door.position.x -= 40
		
		yield(get_tree().create_timer(3), "timeout")
		
		button.disabled = false
