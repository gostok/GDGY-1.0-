extends PointLight2D

@onready var timer: Timer = $Timer


func _on_timer_timeout() -> void:
	var rng = randf_range(0.6, 1.5)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "texture_scale", rng, timer.wait_time)
	tween.parallel().tween_property(self, "energy", rng, timer.wait_time)
	timer.wait_time = randf_range(0.2, 0.6)
