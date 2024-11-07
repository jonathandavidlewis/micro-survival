extends Control

var MAIN_LEVEL = load("res://main_level.tscn")
var MULTIPLAYER_MENU = load("res://ui/multiplayer_menu/multiplayer_menu.tscn")

func _on_single_player_button_pressed() -> void:
  get_tree().change_scene_to_packed(MAIN_LEVEL)
  pass # Replace with function body.


func _on_multiplayer_button_pressed() -> void:
  get_tree().change_scene_to_packed(MULTIPLAYER_MENU)
  
  pass # Replace with function body.
