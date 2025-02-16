extends CanvasLayer

class_name BaseTrack

@onready var light_tracks = $mc_light
@onready var medium_tracks = $mc_medium
@onready var heavy_tracks = $mc_heavy


func _ready() -> void:
	var selected_level = get_tree().get_root().get_meta("selected_level")
	
	if selected_level == null:
		return
	
	_show_tracks_for_level(selected_level)


func _show_tracks_for_level(level: String):
	light_tracks.visible = false
	medium_tracks.visible = false
	heavy_tracks.visible = false
	
	match level:
		"Light":
			light_tracks.visible = true
		"Medium":
			medium_tracks.visible = true
		"Heavy":
			heavy_tracks.visible = true


func _save_selected_track(track_name: String):
	get_tree().get_root().set_meta("selected_track", track_name)
	
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/play_menu/play_menu.tscn")
	

func _on_test_track_pressed() -> void:
	_save_selected_track("01")


func _on_hot_pressed() -> void:
	_save_selected_track("Abyss")


func _on_council_pyramid_pressed() -> void:
	_save_selected_track("Chasm")
