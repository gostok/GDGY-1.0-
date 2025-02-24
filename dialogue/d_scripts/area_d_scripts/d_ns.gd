extends Area2D


@export var dialogue_resource: DialogueResource
@export var dialogue_string: String = 'start'

var dialogue_manager: Node
var biker: Node

var dialogue_started: bool = false
var dialogue_ended: bool = false



func _ready() -> void:
	dialogue_manager = get_tree().get_root().get_node("/root/DialogueManager")





func action() -> void:

	DialogueManager.show_example_dialogue_balloon(dialogue_resource, dialogue_string)



func _start_d():
	print("_start_d()")


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print('true')
		action()
