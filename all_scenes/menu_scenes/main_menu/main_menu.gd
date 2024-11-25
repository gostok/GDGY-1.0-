extends CanvasLayer


func _on_play_menu_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/play_menu/play_menu.tscn")


func _on_exit_game_bt_pressed() -> void:
	get_tree().quit()


func _on_options_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/main_menu/options_menu/options_menu.tscn")
