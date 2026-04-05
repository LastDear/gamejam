var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

var play_w = sprite_get_width(spr_button_play) * button_scale;
var play_h = sprite_get_height(spr_button_play) * button_scale;
var opt_w = sprite_get_width(spr_button_options) * button_scale;
var opt_h = sprite_get_height(spr_button_options) * button_scale;
var auth_w = sprite_get_width(spr_button_authors) * button_scale;
var auth_h = sprite_get_height(spr_button_authors) * button_scale;

var bx = gui_w * 0.5;
var base_y = gui_h * 0.5;
var play_y = base_y;
var opt_y = play_y + play_h + button_gap;
var auth_y = opt_y + opt_h + button_gap;

hover_play = point_in_rectangle(mx, my, bx - play_w * 0.5, play_y - play_h * 0.5, bx + play_w * 0.5, play_y + play_h * 0.5);
hover_options = point_in_rectangle(mx, my, bx - opt_w * 0.5, opt_y - opt_h * 0.5, bx + opt_w * 0.5, opt_y + opt_h * 0.5);
hover_authors = point_in_rectangle(mx, my, bx - auth_w * 0.5, auth_y - auth_h * 0.5, bx + auth_w * 0.5, auth_y + auth_h * 0.5);

if (menu_state == 3) {
    var btn_size = sprite_get_width(spr_button_level1) * level_button_scale;
    var total_w = btn_size * 5 + level_button_gap * 4;
    var start_x = (gui_w - total_w) * 0.5 + btn_size * 0.5;
    var row_y = gui_h * 0.7;

    for (var i = 0; i < 5; i++) {
        var x_btn = start_x + i * (btn_size + level_button_gap);
        level_hover[i] = point_in_rectangle(mx, my, x_btn - btn_size * 0.5, row_y - btn_size * 0.5, x_btn + btn_size * 0.5, row_y + btn_size * 0.5);
    }
} else {
    for (var i = 0; i < 5; i++) {
        level_hover[i] = false;
    }
}

if (keyboard_check_pressed(vk_escape)) {
    if (menu_state == 3 || menu_state == 1 || menu_state == 2) {
        menu_state = 0;
    }
}

if (mouse_check_button_pressed(mb_left)) {
    if (menu_state == 0) {
        if (hover_play) {
            menu_state = 3;
        } else if (hover_options) {
            menu_state = (menu_state == 1) ? 0 : 1;
        } else if (hover_authors) {
            menu_state = (menu_state == 2) ? 0 : 2;
        }
    } else if (menu_state == 3) {
        for (var i = 0; i < 5; i++) {
            if (level_hover[i] && level_unlock_placeholder[i]) {
                if (level_button_rooms[i] != -1) {
                    room_goto(level_button_rooms[i]);
                }
            }
        }
    } else {
        if (hover_options || hover_authors || hover_play) {
            menu_state = 0;
        }
    }
}
