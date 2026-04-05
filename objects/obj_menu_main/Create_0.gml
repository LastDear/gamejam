if (!variable_global_exists("level_best_score")) global.level_best_score = [0, 0, 0, 0, 0];
if (!variable_global_exists("level_best_rank")) global.level_best_rank = ["", "", "", "", ""];
if (!variable_global_exists("level_max_score")) global.level_max_score = [14700, 16800, 12180, 23310, 12600];

menu_state = 0;
button_scale = 0.55;
button_gap = 28;
button_hover_scale = 1.05;
credits_text = "AUTHORS\nSugar Free team\n(edit this text in obj_menu_main/Create_0.gml)";
options_text = "OPTIONS\nEsc - back / restart room\nShift - dash\n1-4 - stances\nLMB - attack";

level_button_scale = 5.0;
level_button_gap = 48;
level_hover_scale = 1.12;
level_unlock_placeholder = variable_global_exists("level_unlocked") ? global.level_unlocked : [true, false, false, false, false];
level_button_sprites = [spr_button_level1, spr_button_level2, spr_button_level3, spr_button_level4, spr_button_level5];
level_button_rooms = [Room1, Room2, Room3, Room4, Room5];
level_hover = [false, false, false, false, false];

if (variable_global_exists("menu_open_level_select") && global.menu_open_level_select) {
    menu_state = 3;
    global.menu_open_level_select = false;
}
