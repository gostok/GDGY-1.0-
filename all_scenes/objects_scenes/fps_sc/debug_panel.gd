extends PanelContainer

var property
var frames_per_second: String

#@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer
@onready var v_box_container = %VBoxContainer


func _ready() -> void:
	visible = false
	
	add_debug_property("FPS", frames_per_second)


func _process(delta: float) -> void:
	if visible:
		frames_per_second = "%.2f" % (1.0/delta)
		property.text = property.name + ": " + frames_per_second


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		visible = !visible


func add_debug_property(title: String, value):
	property = Label.new()
	v_box_container.add_child(property)
	property.name = title
	property.text = property.name + value
