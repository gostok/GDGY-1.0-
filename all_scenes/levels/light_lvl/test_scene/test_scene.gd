extends Node2D

class_name BaseScenes_line

@onready var biker_player = $Biker

@onready var line2d = $StaticBody2D/Line2D  # Ваш узел Line2D
@onready var upper_line2d = $UpperLine2D  # Новый узел Line2D для верхней трассы
@onready var collisionP = $StaticBody2D/collision
@onready var statbod = $StaticBody2D
@onready var flag_start = $flags_timer/f_s/flag_start
@onready var flag_finish = $flags_timer/f_f/flag_finish


var timer = 0
var timer_current = false

var offset = 12.0 # Смещение для создания верхней линии
var collision_offset = 2.5 # Смещение для коллизии
var ground_y = 720 # Y-координата для нижней части коллизии
var right_x = 1280 # X-координата для правой части коллизии


func _ready():
	duplicate_line()
	duplicate_collision()
	duplicate_flags()
	queue_redraw()
	
	if timer_current == true:
		set_process(true)
	else:
		set_process(false)


func start_timer():
	timer_current = true  # Запускаем таймер
	set_process(true)  # Включаем обработку метода _process
	print("Timer started")

func stop_timer():
	timer_current = false  # Останавливаем таймер
	set_process(false)  # Отключаем обработку метода _process
	print("Timer stopped")

func _process(delta) -> void:
	if timer_current:
		timer += delta  # Увеличиваем таймер, если timer_current = true
	
	# Вычисляем минуты, секунды и миллисекунды
	var sec = fmod(timer, 60)
	var mins = fmod(timer, 60 * 60) / 60
	var msec = fmod(timer, 1) * 100
	
	# Форматируем строку таймера
	var timer_passed = "%02d:%02d.%02d" % [mins, sec, msec]
	
	# Обновляем текст метки
	$other/CanvasLayer/Label.text = str(timer_passed)


func _draw():
	var lower_points = line2d.points
	var upper_points = upper_line2d.points
	
	# Проверяем, есть ли точки в обеих линиях
	if lower_points.size() > 0 and upper_points.size() > 0:
		# Закрашиваем пространство между линиями
		var fill_color = Color(229 / 255.0, 21 / 255.0, 191 / 255.0, 0.2)  # Альфа-канал 
		var polygon_points = get_polygon_between_lines(lower_points, upper_points)
		draw_polygon(polygon_points, [fill_color])  # Передаем массив точек и массив цветов
		draw_connecting_lines(lower_points, upper_points)  # Рисуем соединительные линии

func duplicate_line():
	var points = line2d.points  # Получаем точки из нижней линии
	upper_line2d.clear_points()  # Очищаем предыдущие точки верхней линии
	
	for point in points:
		upper_line2d.add_point(point + Vector2(0, -offset))  # Смещаем точку вверх

	queue_redraw()

func duplicate_collision():
	var new_collision = CollisionPolygon2D.new()
	var line_points = line2d.points
	var new_polygon = []
	
	for point in line_points:
		var new_point = point + Vector2(0, -collision_offset)
		new_polygon.append(new_point)
	
	new_polygon.append(Vector2(right_x, ground_y))
	new_polygon.append(Vector2(-line_points[line_points.size() - 1].x, ground_y))
	
	# Замыкаем полигон
	if new_polygon.size() > 0:
		new_polygon.append(new_polygon[0])  # Замыкаем полигон

	new_collision.polygon = new_polygon
	statbod.add_child(new_collision)
	new_collision.set_deferred("disabled", false)


func duplicate_flags():
	# Дублируем флаг старт
	var start_flag_copy = flag_start.duplicate()
	start_flag_copy.position = flag_start.position + Vector2(4, -offset)  # Смещение вправо и вверх
	add_child(start_flag_copy)  # Добавляем копию в текущий узел
	start_flag_copy.z_index = flag_start.z_index - 1  # Устанавливаем Z-индекс ниже оригинала

	# Дублируем флаг финиш
	var finish_flag_copy = flag_finish.duplicate()
	finish_flag_copy.position = flag_finish.position + Vector2(4, -offset)  # Смещение вправо и вверх
	add_child(finish_flag_copy)  # Добавляем копию в текущий узел
	finish_flag_copy.z_index = flag_finish.z_index - 1  # Устанавливаем Z-индекс ниже оригинала



func get_polygon_between_lines(lower_points: Array, upper_points: Array) -> Array:
	var polygon = []
	
	for point in lower_points:
		polygon.append(point)
	
	for i in range(upper_points.size() - 1, -1, -1):
		polygon.append(upper_points[i])
	
	# Замыкаем полигон
	if polygon.size() > 0 and polygon[0] != polygon[polygon.size() - 1]:
		polygon.append(polygon[0])  # Замыкаем полигон, добавляя первую точку в конец

	return polygon

func draw_connecting_lines(lower_points: Array, upper_points: Array):
	for i in range(lower_points.size()):
		if i < upper_points.size():  # Проверка на соответствие размеров
			var lower_point = lower_points[i]
			var upper_point = upper_points[i]
			var color_con_lines = Color(0/255.0, 255/255.0, 128/255.0)
			draw_line(lower_point, upper_point, color_con_lines, 1.0)  # Цвет соединительных линий


func _on_area_2d_flagstart_body_entered(body):
	if body.is_in_group("player"):
		print("start")
		start_timer()


func _on_area_2d_flagfinish_body_entered(body):
	if body.is_in_group("player"):
		print("finish")
		stop_timer()
