extends CanvasLayer

class_name LvlCompleted

@onready var place_record_label = $MarginContainer/VBoxContainer/place
@onready var timer_label = $MarginContainer/VBoxContainer/time


func _ready() -> void:
	var timer_level = get_tree().get_root().get_meta("timer_record")
	timer_label.text = timer_level


func _on_ok_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://all_scenes/menu_scenes/play_menu/play_menu.tscn")
