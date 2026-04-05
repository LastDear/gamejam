draw_self();

// =========================
// ПРОСТОЙ ИНДИКАТОР УДАРА
// =========================
if (is_attacking) {
    var fx_progress = image_index / max(1, image_number - 1);
    var fx_alpha = 0;

    if (fx_progress <= 0.85) {
        fx_alpha = (0.38 - abs(fx_progress - 0.40) * 0.75) * 0.3;
    }
    fx_alpha = clamp(fx_alpha, 0, 0.28);

    if (fx_alpha > 0.01) {
        var swing_dir = dir ? 1 : -1;
        var hit_left = dir ? (x + attack_offset_left) : (x - attack_offset_right);
        var hit_right = dir ? (x + attack_offset_right) : (x - attack_offset_left);
        var hit_top = y + attack_offset_top;
        var hit_bottom = y + attack_offset_bottom;

        var circle_x = (hit_left + hit_right) * 0.5;
        var circle_y = (hit_top + hit_bottom) * 0.5;
        var circle_r = max(16, max(abs(hit_right - hit_left), abs(hit_bottom - hit_top)) * 0.45);
        circle_x += swing_dir * 4;

        draw_set_alpha(fx_alpha * 0.65);
        draw_set_color(merge_color(stance_color, c_white, 0.45));
        draw_circle(circle_x, circle_y, circle_r + 5, false);

        draw_set_alpha(fx_alpha);
        draw_set_color(stance_color);
        draw_circle(circle_x, circle_y, circle_r, false);

        draw_set_alpha(fx_alpha * 0.7);
        draw_set_color(c_white);
        draw_circle(circle_x, circle_y, max(8, circle_r - 6), true);
    }

    draw_set_alpha(1);
    draw_set_color(c_white);
}
