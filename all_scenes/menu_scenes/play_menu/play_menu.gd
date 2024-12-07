extends CanvasLayer

@onready var level_button = $MarginContainer/VBoxContainer/Level_bt
@onready var track_button = $MarginContainer/VBoxContainer/Track_bt
@onready var start_button = $MarginContainer/VBoxContainer/Start_bt

func _ready() -> void:
	var selected_level = get_tree().get_root().get_meta("selected_level")
	if selected_level:
		level_button.text = "Level: " + selected_level
		
	var selected_track = get_tree().get_root().get_meta("selected_track")
	if selected_track:
		track_button.text = "Track: " + selected_track

func _on_level_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/play_menu/level_menu/level_menu.tscn")


func _on_back_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/main_menu/main_menu.tscn")


func _on_track_bt_pressed() -> void:
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/play_menu/track_menu/track_menu.tscn")


func _on_start_bt_pressed() -> void:
	var selected_track = get_tree().get_root().get_meta("selected_track")
	
	if selected_track:
		match  selected_track:
			"01":
				get_tree().change_scene_to_file("res://all_scenes/levels/light_lvl/test_scene/test_scene.tscn")
			"Hot":
				get_tree().change_scene_to_file("res://all_scenes/levels/light_lvl/hot_lvl/hot_level.tscn")
			"Council_Pyramid":
				get_tree().change_scene_to_file("res://all_scenes/levels/light_lvl/council_pyramid/council_pyramid.tscn")
