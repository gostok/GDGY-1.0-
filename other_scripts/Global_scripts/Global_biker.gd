extends Node

# переменная для проверки, первое ли прохождение карты 'Vice'
var start_vice_biker: bool = false
# переменная для проверки, первое ли прохождение карты 'Abyss'
var start_abyss_biker: bool = false
# переменная для проверки, первое ли прохождение карты 'Neon_Streets'
var start_ns_biker: bool = false
# переменная для проверки, первое ли прохождение карты 'Metropolis_Beats'
var start_mb_biker: bool = false

# Переменные для разных концовок сюжета игры
var road_pain: bool = false
var road_sinner: bool = false
var road_WagerWithGod: bool = false
var road_dark_guide: bool = true

# Переменные для разных изменений в ходе сюжета
var dark_guide: bool = false
var take_a_drug: bool = false

# Переменные для отссылок к другим играм, фильмам, или книгам
var link_the_witcher = false


# Переменная для хранения количества смертей
var death_count: int = 0

# Метод для увеличения количества смертей
func increment_death_count():
	death_count += 1


# Метод для получения текущего количества смертей
func get_death_count() -> int:
	return death_count
