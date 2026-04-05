// =========================
// ГЛОБАЛЬНЫЙ ПРОГРЕСС
// =========================
if (!variable_global_exists("level_unlocked")) {
    global.level_unlocked = [true, false, false, false, false];
}
if (!variable_global_exists("menu_open_level_select")) {
    global.menu_open_level_select = false;
}
if (!variable_global_exists("level_best_score")) {
    global.level_best_score = [0, 0, 0, 0, 0];
}
if (!variable_global_exists("level_best_rank")) {
    global.level_best_rank = ["", "", "", "", ""];
}
if (!variable_global_exists("level_max_score")) {
    global.level_max_score = [14700, 16800, 12180, 23310, 12600];
}

// =========================
// ТЕКУЩАЯ МУЗЫКА / РИТМ
// =========================
global.music_instance = noone;
global.current_music_asset = -1;
global.current_music_track_pos = 0;
global.current_room_bpm = 120;
global.current_room_music_start_sec = 0;
global.current_room_bar_start_sec = 0;
global.current_room_name_for_music = "";

// =========================
// НАСТРОЙКИ МУЗЫКИ ПО КОМНАТАМ
// меняй здесь sound / bpm / start / bar start
// start_sec = с какой позиции трека стартовать
// bar_start_sec = с какой позиции трека начинать цикл полосы бита
// =========================
room1_music = snd_room1;
room1_bpm = 65;
room1_start_sec = 0;
room1_bar_start_sec = 0.5;

room2_music = snd_room2;
room2_bpm = 120;
room2_start_sec = 0;
room2_bar_start_sec = 0.2;

room3_music = snd_room3;
room3_bpm = 130;
room3_start_sec = 0;
room3_bar_start_sec = 0.2;

room4_music = snd_room4;
room4_bpm = 140;
room4_start_sec = 0;
room4_bar_start_sec = 0.2;

room5_music = snd_room5;
room5_bpm = 150;
room5_start_sec = 0;
room5_bar_start_sec = 0.15;
