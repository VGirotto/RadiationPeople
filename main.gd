extends Node2D

var Minion =  preload("res://Cenas/Minion.tscn")
var Gas =  preload("res://Cenas/Gas.tscn")
var Cop =  preload("res://Cenas/Cop.tscn")
var Med =  preload("res://Cenas/Med.tscn")
var Bomb =  preload("res://Cenas/SlowBomb.tscn")
onready var gasTimer = get_node("GasTime")
onready var vaccineTimer = get_node("VaccineTimer")
onready var gas = get_node("gas")
onready var Text = get_node("Text")
onready var vaccine = get_node("Vaccine")
onready var copButton = get_node("CopButton")
onready var timerHelp = get_node("TimerHelp")
onready var medButton = get_node("MedButtun")
onready var pauseScreen = get_node("pauseBG")
onready var pauseButton = get_node("PauseButton")

var total = 0
var counter = 0
var perc = 0
var index
var aux
var aux2
var putCop = false
var cop
var putMed = false
var med
var medCounter = 0
var bar = 0
var putBomb = false
var slowBomb = false
var bomb

var pos = [[100, 472], [100, 256], [100, 140], [100, 560], [100, 660],
[256, 140], [430, 140], [430, 256], [430, 460], [256, 460], [256, 660],
[663, 660], [663, 500], [663, 400], [663, 250], [1000, 660], [800, 660],
[1207, 660], [1207, 480], [1207, 232], [962, 232], [800, 232], [660, 232],
[962, 32], [750, 32], [600, 32], [430, 32]]

var posGas = [[260, 460], [410, 300], [100, 570], [400, 660], [400, 660], [960, 660], [660, 400], [700, 30], [1200, 400]]

# Called when the node enters the scene tree for the first time.
func _ready():
	Sot.get_node("/root/Sot").stop()
	randomize()
	if randi() % 2 == 0:
		$sot1.play()
	else:
		$sot2.play()
	var mini
	var qtd = 150
	total += qtd
	# create minions
	for i in range(qtd):
		mini = Minion.instance()
		randomize()
		index = i % 27
		mini.position = Vector2(pos[index][0], pos[index][1])
		mini.get_node("CollisionShape2D/Sprite").modulate = Color(float(randi()%100)/100, float(randi()%100)/100, float(randi()%100)/100, 1)
		self.add_child(mini)
	gasTimer.start(5)

func _process(delta):
	# update texts
	if !gasTimer.is_stopped():
		Text.set_text("Starts in: " + String(stepify(gasTimer.time_left, 0.1)))
	else:
		Text.set_text("Number of contaminated: " + String(counter))
		vaccine.set_text("Launch vaccine: " + String(stepify(vaccineTimer.time_left, 0.1)))
		if stepify(vaccineTimer.time_left, 0.01) == round(vaccineTimer.time_left) and round(vaccineTimer.time_left) != aux2:
			bar += 2
			aux2 = round(vaccineTimer.time_left)
			$seringa/ProgressBar.set_value(bar)
		perc = float(counter)/float(total)
		$becker/ProgressBar.set_value(perc*100)
	
	# follow the mouse
	if putCop:
		cop.position = get_global_mouse_position()
	elif putMed:
		med.position = get_global_mouse_position()
	elif putBomb:
		bomb.position = get_global_mouse_position()
	
	if slowBomb:
		$SlowBomb.disabled = false

func _on_GasTime_timeout():
	timerHelp.start(3)
	vaccineTimer.start(50)
	$Songs/gas.play()
	
	# Start gas and contamination
	randomize()
	index = randi() % 9
	gas.position = Vector2(posGas[index][0], posGas[index][1])
	gas.visible = true
	gas.get_node("Gas").playing = true
	gas.monitoring = true
	
	yield(get_tree().create_timer(2), "timeout")

	gas.visible = false
	gas.monitoring = false


func _on_gas_body_entered(body):  # first contamineds
	if body is KinematicBody2D:
		if body.get_filename() != Cop.get_path():
			counter += 1
			body.contamined = true
			body.get_node("CollisionShape2D/exclama").visible = true
			body.get_node("CollisionShape2D/Sprite").modulate = Color(0.19, 0.96, 0, 1)


func _on_CopButton_pressed():
	copButton.disabled = true
	if putMed:
		putMed = false
		remove_child(med)
		medButton.disabled = false
	elif putBomb:
		putBomb = false
		remove_child(bomb)
		slowBomb = true
	
	if !putCop: # tem que checar quantidade ou tempo
		cop = Cop.instance()
		putCop = true
		cop.modulate.a = 0.5
		add_child(cop)

func _input(ev):
	if !(get_global_mouse_position().x > 1100 and get_global_mouse_position().y < 180):
		if putCop:
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				#put Cop
				$Songs/put.play()
				total += 1
				putCop = false
				cop.modulate.a = 1
				cop.get_dir(["right", "up", "down", "left"])
		elif putMed:
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				#put Med
				$Songs/put.play()
				putMed = false
				med.modulate.a = 1
				med.get_dir(["right", "up", "down", "left"])
				medCounter += 1
		elif putBomb:
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				#put Bomb
				slowBomb = false
				bomb.timer.start(5)
				$Songs/gas.play()
				putBomb = false
				bomb.modulate.a = 1


func _on_TimerHelp_timeout():
	copButton.disabled = false
	medButton.disabled = false
	$SlowBomb.disabled = false


func _on_MedButtun_pressed():
	medButton.disabled = true
	#desative putCop
	if putCop:
		putCop = false
		remove_child(cop)
		copButton.disabled = false
	elif putBomb:
		putBomb = false
		remove_child(bomb)
		slowBomb = true
		
	if !putMed: 
		med = Med.instance()
		putMed = true
		med.modulate.a = 0.5
		add_child(med)


func _on_VaccineTimer_timeout():
	if perc >= 0.99:
		$Songs/gameover.play()
	else:
		$Songs/win.play()
	# pause e present final screen
	get_tree().paused = not get_tree().paused
	get_node("Final/Pontuation").set_text(String(counter))
	#get possible position
#	yield(SilentWolf.Scores.get_score_position((1000 - counter)), "sw_position_received")
#	get_node("Final").get_node("position").set_text(String(SilentWolf.Scores.position) + "*")
	get_node("Final").visible = true
	pauseScreen.visible = not pauseScreen.visible
	pauseButton.disabled = true


func _on_PauseButton_pressed():
	get_tree().paused = not get_tree().paused
	pauseScreen.visible = not pauseScreen.visible
	get_node("BackMenu").visible = not get_node("BackMenu").visible


func _on_Back_to_Menu_pressed():
	get_tree().change_scene("res://Cenas/TitleScreen/Interface.tscn")
	get_tree().paused = not get_tree().paused


func _on_sot1_finished():
	$sot1.play()

func _on_sot2_finished():
	$sot2.play()


func _on_SlowBomb_pressed():
	slowBomb = false
	$SlowBomb.disabled = true
	#desative putCop
	if putCop:
		putCop = false
		remove_child(cop)
	elif putMed:
		putMed = false
		remove_child(med)
		
	if !putBomb: 
		bomb = Bomb.instance()
		putBomb = true
		bomb.modulate.a = 0.5
		add_child(bomb)
