extends Node

var is_game_paused = false

func resume_game():
	get_tree().paused = false
	is_game_paused = false
	print("je mets le jeu en marche")

func pause_game():
	get_tree().paused = true
	is_game_paused = true
	print("je mets le jeu en pause")
