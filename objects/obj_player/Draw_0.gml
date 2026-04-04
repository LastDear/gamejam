draw_self();

// =========================
// ДЕБАГ ХИТБОКСА АТАКИ
// =========================
if (debug_draw_attack_hitbox && is_attacking && floor(image_index) == attack_hit_frame) {

    var hit_left, hit_right;

    if (dir) {
        hit_left  = x + attack_offset_left;
        hit_right = x + attack_offset_right;
    } else {
        hit_left  = x - attack_offset_right;
        hit_right = x - attack_offset_left;
    }

    var hit_top = y + attack_offset_top;
    var hit_bottom = y + attack_offset_bottom;

    draw_set_alpha(0.25);
    draw_set_color(c_red);
    draw_rectangle(hit_left, hit_top, hit_right, hit_bottom, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_rectangle(hit_left, hit_top, hit_right, hit_bottom, true);
}