extends Node2D

export var starting_lives = 3
export var coin_target = 5 #How manu coins for an extra life

var lives
var coins = 0

onready var GUI = Global.GUI

func _ready():
	Global.GameState = self
	lives = starting_lives
	update_GUI()

func update_GUI():
	Global.GUI.update_GUI(coins, lives)

func animate_GUI(animation):
	GUI.animate(animation)

func hurt():
	lives -= 1
	update_GUI()
	Global.Player.hurt()
	animate_GUI("Hurt")
	Global.pain_sfx.play()
	if lives < 0:
		end_game()

func coin_up():
	coins += 1
	update_GUI()
	animate_GUI("CoinPulse")
	var multiple_of_coin_target = (coins % coin_target) == 0
	if multiple_of_coin_target:
		life_up()

func life_up():
	lives += 1
	update_GUI()
	animate_GUI("LifePulse")

func end_game():
	get_tree().change_scene(Global.GameOver)

func win_game():
	get_tree().change_scene(Global.Victory)

func _on_Portal_body_entered(body):
	win_game()
