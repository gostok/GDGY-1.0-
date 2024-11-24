extends CanvasLayer




func _on_light_bt_pressed() -> void:
	_set_level("Light")


func _on_medium_bt_pressed() -> void:
	_set_level("Medium")


func _on_heavy_bt_pressed() -> void:
	_set_level("Heavy")


func _set_level(level: String):
	get_tree().get_root().set_meta("selected_level", level)
	
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/play_menu/play_menu.tscn")
