extends CanvasLayer


func _on_back_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/main_menu/main_menu.tscn")
