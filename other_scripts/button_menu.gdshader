shader_type canvas_item;

uniform vec4 glow_color; // Цвет свечения
uniform float glow_strength; // Сила свечения
uniform float glow_radius; // Радиус свечения

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV); // Получаем цвет текстуры (текста)
    vec4 final_color = tex_color; // Начинаем с цвета текста

    // Если текст не прозрачный
    if (tex_color.a > 0.0) {
        // Добавляем свечение на основе цвета текста
        final_color += glow_color * glow_strength;

        // Добавляем свечение вокруг текста
        for (float x = -glow_radius; x <= glow_radius; x++) {
            for (float y = -glow_radius; y <= glow_radius; y++) {
                vec2 offset = vec2(x, y) / 100.0; // Нормализуем смещение
                vec4 sample = texture(TEXTURE, UV + offset);
                if (sample.a > 0.0) {
                    final_color += glow_color * (glow_strength * 0.5); // Уменьшаем силу свечения
                }
            }
        }
    }

    // Устанавливаем цвет с учетом альфа-канала
    final_color.a = tex_color.a; // Сохраняем альфа-канал текста
    COLOR = final_color; // Устанавливаем финальный цвет
}
