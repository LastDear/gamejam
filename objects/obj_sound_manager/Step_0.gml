var target_sound = -1;
var target_bpm = 120;
var target_start_sec = 0;
var target_bar_start_sec = 0;
var target_room_name = room_get_name(room);

switch (room) {
    case Room1:
        target_sound = room1_music;
        target_bpm = room1_bpm;
        target_start_sec = room1_start_sec;
        target_bar_start_sec = room1_bar_start_sec;
        break;

    case Room2:
        target_sound = room2_music;
        target_bpm = room2_bpm;
        target_start_sec = room2_start_sec;
        target_bar_start_sec = room2_bar_start_sec;
        break;

    case Room3:
        target_sound = room3_music;
        target_bpm = room3_bpm;
        target_start_sec = room3_start_sec;
        target_bar_start_sec = room3_bar_start_sec;
        break;

    case Room4:
        target_sound = room4_music;
        target_bpm = room4_bpm;
        target_start_sec = room4_start_sec;
        target_bar_start_sec = room4_bar_start_sec;
        break;

    case Room5:
        target_sound = room5_music;
        target_bpm = room5_bpm;
        target_start_sec = room5_start_sec;
        target_bar_start_sec = room5_bar_start_sec;
        break;
}

var need_restart_music = false;
if (global.current_room_name_for_music != target_room_name) need_restart_music = true;
if (global.current_music_asset != target_sound) need_restart_music = true;

if (need_restart_music) {
    if (global.music_instance != noone) {
        audio_stop_sound(global.music_instance);
    }

    if (target_sound != -1) {
        global.music_instance = audio_play_sound(target_sound, 2, true);
        audio_sound_set_track_position(global.music_instance, target_start_sec);
    } else {
        global.music_instance = noone;
    }

    global.current_music_asset = target_sound;
    global.current_room_name_for_music = target_room_name;
}

global.current_room_bpm = target_bpm;
global.current_room_music_start_sec = target_start_sec;
global.current_room_bar_start_sec = target_bar_start_sec;

if (global.music_instance != noone) {
    global.current_music_track_pos = audio_sound_get_track_position(global.music_instance);
} else {
    global.current_music_track_pos = 0;
}
