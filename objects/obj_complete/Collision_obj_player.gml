var level_index = 0;
audio_stop_all();
switch (room) {
    case Room1: level_index = 1; break;
    case Room2: level_index = 2; break;
    case Room3: level_index = 3; break;
    case Room4: level_index = 4; break;
    case Room5: level_index = 5; break;
}

if (!variable_global_exists("level_unlocked")) global.level_unlocked = [true, false, false, false, false];
if (!variable_global_exists("level_best_score")) global.level_best_score = [0, 0, 0, 0, 0];
if (!variable_global_exists("level_best_rank")) global.level_best_rank = ["", "", "", "", ""];
if (!variable_global_exists("level_max_score")) global.level_max_score = [14700, 16800, 12180, 23310, 12600];

if (level_index > 0) {
    var final_score = 0;

    if (instance_exists(other) && variable_instance_exists(other, "run_score")) {
        final_score = other.run_score;
    }
    else {
        var pl = instance_find(obj_player, 0);
        if (pl != noone && variable_instance_exists(pl, "run_score")) {
            final_score = pl.run_score;
        }
    }

    if (final_score > global.level_best_score[level_index - 1]) {
        global.level_best_score[level_index - 1] = final_score;
    }

    var ratio = 0;
    if (global.level_max_score[level_index - 1] > 0) ratio = final_score / global.level_max_score[level_index - 1];
    var final_rank = "C";
    if (ratio >= 1.0) final_rank = "SS";
    else if (ratio >= 0.8) final_rank = "S";
    else if (ratio >= 0.6) final_rank = "A";
    else if (ratio >= 0.4) final_rank = "B";
    global.level_best_rank[level_index - 1] = final_rank;

    var next_index = level_index + 1;
    if (next_index <= 5) {
        global.level_unlocked[next_index - 1] = true;
    }
}

global.menu_open_level_select = true;
room_goto(RoomMenu);
