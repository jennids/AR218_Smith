extends Node2D

func _on_Play_pressed():
	get_tree().change_scene("res://Levels/Level2.tscn")


func _on_How_to_Play_pressed():
	get_tree().change_scene("res://Scenes/HowToPlay.tscn")


func _on_Artist_Statement_pressed():
	get_tree().change_scene("res://Scenes/ArtistStatement.tscn")
