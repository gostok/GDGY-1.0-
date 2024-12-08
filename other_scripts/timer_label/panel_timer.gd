extends Panel

var m_l
var s_l
var msec_l

var time: float = 0.0
var timer_current = false

func _ready() -> void:
	print("Проверка узлов...")
	print("Доступные дочерние узлы: ", get_children())

	m_l = get_node("min")
	s_l = get_node("sec")
	msec_l = get_node("msec")

	if m_l == null:
		print("min узел не найден!")
	else:
		print("min узел найден!")

	if s_l == null:
		print("sec узел не найден!")
	else:
		print("sec узел найден!")

	if msec_l == null:
		print("msec узел не найден!")
	else:
		print("msec узел найден!")



func start_timer():
	timer_current = true


func stop_timer():
	timer_current = false


func _process(delta) -> void:
	if timer_current:
		time += delta
		var msec = int((time - int(time)) * 100)
		var seconds = int(time) % 60
		var minutes = int(time) / 60

		# Проверка на null только здесь
		if m_l and s_l and msec_l:
			m_l.text = "%02d: " % minutes
			s_l.text = "%02d." % seconds
			msec_l.text = "%03d" % msec
		else:
			print("Ошибка: один или несколько узлов все еще null!")
