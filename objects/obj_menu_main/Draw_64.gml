var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

if (menu_state == 3) {
    var bg_w = sprite_get_width(spr_bg_level_select);
    var bg_h = sprite_get_height(spr_bg_level_select);
    var bg_scale = max(gui_w / bg_w, gui_h / bg_h);
    var bg_draw_w = bg_w * bg_scale;
    var bg_draw_h = bg_h * bg_scale;
    var bg_x = (gui_w - bg_draw_w) * 0.5;
    var bg_y = (gui_h - bg_draw_h) * 0.5;
    draw_sprite_stretched(spr_bg_level_select, 0, bg_x, bg_y, bg_draw_w, bg_draw_h);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);

    var btn_size = sprite_get_width(spr_button_level1) * level_button_scale;
    var total_w = btn_size * 5 + level_button_gap * 4;
    var start_x = (gui_w - total_w) * 0.5 + btn_size * 0.5;
    var row_y = gui_h * 0.7;

    for (var i = 0; i < 5; i++) {
        var spr = level_button_sprites[i];
        var x_btn = start_x + i * (btn_size + level_button_gap);
        var unlocked = level_unlock_placeholder[i];
        var scale = level_button_scale;
        if (unlocked && level_hover[i]) {
            scale *= level_hover_scale;
        }

        if (unlocked) {
            draw_sprite_ext(spr, 0, x_btn, row_y, scale, scale, 0, c_white, 1);
        } else {
            draw_sprite_ext(spr, 0, x_btn, row_y, level_button_scale, level_button_scale, 0, make_color_rgb(120, 120, 120), 0.55);
            draw_sprite_ext(spr_button_level_locked, 0, x_btn, row_y, level_button_scale, level_button_scale, 0, c_white, 0.95);
        }
    }

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(48, gui_h - 72, "ESC - back");
} else {
    var bg_w = sprite_get_width(spr_backgr_main);
    var bg_h = sprite_get_height(spr_backgr_main);
    var bg_scale = max(gui_w / bg_w, gui_h / bg_h);
    var bg_draw_w = bg_w * bg_scale;
    var bg_draw_h = bg_h * bg_scale;
    var bg_x = (gui_w - bg_draw_w) * 0.5;
    var bg_y = (gui_h - bg_draw_h) * 0.5;

    draw_sprite_stretched(spr_backgr_main, 0, bg_x, bg_y, bg_draw_w, bg_draw_h);

    var bx = gui_w * 0.5;
    var base_y = gui_h * 0.5;

    var play_scale = button_scale * (hover_play ? button_hover_scale : 1);
    var opt_scale = button_scale * (hover_options ? button_hover_scale : 1);
    var auth_scale = button_scale * (hover_authors ? button_hover_scale : 1);

    var play_h = sprite_get_height(spr_button_play) * button_scale;
    var opt_h = sprite_get_height(spr_button_options) * button_scale;
    var play_y = base_y;
    var opt_y = play_y + play_h + button_gap;
    var auth_y = opt_y + opt_h + button_gap;

    draw_sprite_ext(spr_button_play, 0, bx, play_y, play_scale, play_scale, 0, c_white, 1);
    draw_sprite_ext(spr_button_options, 0, bx, opt_y, opt_scale, opt_scale, 0, c_white, 1);
    draw_sprite_ext(spr_button_authors, 0, bx, auth_y, auth_scale, auth_scale, 0, c_white, 1);

    if (menu_state != 0) {
        var panel_w = 470;
        var panel_h = 210;
        var px1 = gui_w - panel_w - 42;
        var py1 = 42;
        var px2 = px1 + panel_w;
        var py2 = py1 + panel_h;
        draw_set_alpha(0.84);
        draw_set_color(c_black);
        draw_roundrect(px1, py1, px2, py2, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
        if (menu_state == 1) {
            draw_text(px1 + 24, py1 + 24, options_text);
        } else if (menu_state == 2) {
            draw_text(px1 + 24, py1 + 24, credits_text);
        }
    }
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
