// =========================
// ВВОД
// =========================
var a = keyboard_check(ord("A"));
var d = keyboard_check(ord("D"));
var k1 = keyboard_check_pressed(ord("1"));
var k2 = keyboard_check_pressed(ord("2"));
var k3 = keyboard_check_pressed(ord("3"));
var k4 = keyboard_check_pressed(ord("4"));
var space = keyboard_check_pressed(vk_space);
var attack = mouse_check_button_pressed(mb_left);
var dash = keyboard_check_pressed(vk_shift);

// =========================
// СТОЙКИ
// =========================
var requested_stance = stance_mode;
if (k1) requested_stance = 1;
if (k2) requested_stance = 2;
if (k3) requested_stance = 3;
if (k4) requested_stance = 4;

if (requested_stance != stance_mode || stance_name == "") {
    var hp_ratio_keep = 1;
    if (max_hp > 0) hp_ratio_keep = hp / max_hp;
    stance_mode = requested_stance;

    move_speed = base_move_speed;
    jump_speed = base_jump_speed;
    grav_acc = base_grav_acc;
    max_fall_speed = base_max_fall_speed;
    attack_damage = base_attack_damage;
    attack_knock_x = base_attack_knock_x;
    attack_knock_y = base_attack_knock_y;
    attack_anim_speed = base_attack_anim_speed;
    attack_cooldown_time = base_attack_cooldown_time;
    dash_speed = base_dash_speed;
    dash_time = base_dash_time;
    dash_cooldown_time = base_dash_cooldown_time;
    dash_rhythm_speed_bonus = base_dash_rhythm_speed_bonus;
    dash_rhythm_time_bonus = base_dash_rhythm_time_bonus;
    attack_rhythm_damage_mult = base_attack_rhythm_damage_mult;
    score_rhythm_mult = base_score_rhythm_mult;
    rhythm_window = base_rhythm_window;
    damage_taken_mult = 1.0;
    max_hp = base_max_hp;

    switch (stance_mode) {
        case 1: // HARDER
            stance_name = "HARDER";
            stance_color = make_color_rgb(220, 90, 90);
            spr_idle = spr_h_player_idle;
            spr_run = spr_h_player_run;
            spr_jump = spr_h_player_jump;
            spr_dash = spr_h_player_dodge;
            spr_hurt = spr_h_player_hit;
            spr_attack = spr_h_player_hit;
            move_speed = 3.3;
            jump_speed = -11.2;
            max_hp = 140;
            damage_taken_mult = 0.75;
            dash_cooldown_time = 38;
            break;

        case 2: // BETTER
            stance_name = "BETTER";
            stance_color = make_color_rgb(120, 220, 120);
            spr_idle = spr_b_player_idle;
            spr_run = spr_b_player_run_hit;
            spr_jump = spr_b_player_jump;
            spr_dash = spr_b_player_dodge;
            spr_hurt = spr_b_player_hit;
            spr_attack = spr_b_player_hit;
            rhythm_window = 8;
            attack_rhythm_damage_mult = 1.35;
            score_rhythm_mult = 1.40;
            dash_cooldown_time = 24;
            break;

        case 3: // FASTER
            stance_name = "FASTER";
            stance_color = make_color_rgb(90, 190, 255);
            spr_idle = spr_f_player_idle;
            spr_run = spr_f_player_run;
            spr_jump = spr_f_player_jump;
            spr_dash = spr_f_player_dodge;
            spr_hurt = spr_f_player_hit;
            spr_attack = spr_f_player_hit;
            move_speed = 5.2;
            jump_speed = -13.2;
            max_fall_speed = 9.5;
            dash_speed = 14;
            dash_time = 9;
            dash_rhythm_speed_bonus = 6;
            dash_rhythm_time_bonus = 5;
            dash_cooldown_time = 18;
            attack_damage = 21;
            break;

        case 4: // STRONGER
            stance_name = "STRONGER";
            stance_color = make_color_rgb(255, 210, 90);
            spr_idle = spr_s_player_idle;
            spr_run = spr_s_player_run;
            spr_jump = spr_s_player_jump;
            spr_dash = spr_s_player_dodge;
            spr_hurt = spr_s_player_hit;
            spr_attack = spr_s_player_hit;
            move_speed = 3.7;
            attack_damage = 34;
            attack_knock_x = 14;
            attack_knock_y = -3;
            attack_cooldown_time = 0.42;
            score_rhythm_mult = 1.30;
            break;
    }

    hp = clamp(round(max_hp * hp_ratio_keep), 1, max_hp);
}

// =========================
// РИТМ
// =========================
rhythm_timer += 1;
if (rhythm_timer >= rhythm_interval) {
    rhythm_timer -= rhythm_interval;
}

var beat_phase = rhythm_timer;
var beat_center = rhythm_interval * 0.5;
var beat_distance = abs(beat_phase - beat_center);
var in_rhythm = (beat_distance <= rhythm_window);

// =========================
// ТАЙМЕРЫ
// =========================
if (hurt_timer > 0) {
    hurt_timer--;
    if (hurt_timer <= 0) {
        image_blend = c_white;
    }
}
if (invulnerable_timer > 0) invulnerable_timer--;
if (dash_cooldown > 0) dash_cooldown--;
if (rhythm_feedback_timer > 0) rhythm_feedback_timer--;

knock_hspd *= knock_friction;
if (abs(knock_hspd) < 0.1) knock_hspd = 0;

// =========================
// ПРОВЕРКА ПОЛА
// =========================
var on_ground = place_meeting(x, y + 1, obj_wall);

// =========================
// DASH
// =========================
if (dash && !is_dashing && !is_attacking && dash_cooldown <= 0) {
    last_rhythm_success = in_rhythm;
    dash_rhythm_invul = in_rhythm;

    is_dashing = true;
    dash_timer = dash_time;
    dash_hspd = (dir ? 1 : -1) * dash_speed;

    if (in_rhythm) {
        dash_timer += dash_rhythm_time_bonus;
        dash_hspd += (dir ? 1 : -1) * dash_rhythm_speed_bonus;
        invulnerable_timer = max(invulnerable_timer, dash_timer);
        rhythm_feedback_text = "DASH ON BEAT!";
    } else {
        rhythm_feedback_text = "OFF BEAT";
    }

    rhythm_feedback_timer = 12;
    dash_cooldown = dash_cooldown_time;
}

// =========================
// ДВИЖЕНИЕ / ПРЫЖОК / ГРАВИТАЦИЯ
// =========================
if (is_dashing) {
    hspd = dash_hspd;
    vspd = 0;

    if (dash_rhythm_invul) {
        invulnerable_timer = max(invulnerable_timer, dash_timer);
    }

    dash_timer--;
    if (dash_timer <= 0) {
        is_dashing = false;
        dash_rhythm_invul = false;
        hspd = 0;
    }
} else {
    var move_hspd = (d - a) * move_speed;
    hspd = move_hspd + knock_hspd;

    if (on_ground && space) vspd = jump_speed;
    if (!on_ground) vspd += grav_acc;
    vspd = clamp(vspd, -100, max_fall_speed);
}

// =========================
// ПОВОРОТ
// =========================
if (!is_dashing) {
    if (hspd > 0) {
        image_xscale = 1;
        dir = true;
    } else if (hspd < 0) {
        image_xscale = -1;
        dir = false;
    }
}

// =========================
// СТАРТ АТАКИ
// =========================
if (attack && !is_attacking && !attack_cooldown && !is_dashing) {
    is_attacking = true;
    attack_cooldown = true;
    damage_applied = false;
    attack_rhythm_bonus = in_rhythm;

    if (attack_rhythm_bonus) {
        rhythm_feedback_text = "HIT ON BEAT!";
        rhythm_feedback_timer = 12;
    }

    sprite_index = spr_attack;
    image_index = 0;
    image_speed = attack_anim_speed;
    alarm[0] = ceil(room_speed * attack_cooldown_time);
}

// =========================
// ОБРАБОТКА АТАКИ
// =========================
if (is_attacking) {
    if (floor(image_index) >= attack_hit_frame && !damage_applied) {
        damage_applied = true;

        var hit_left, hit_right;
        if (dir) {
            hit_left = x + attack_offset_left;
            hit_right = x + attack_offset_right;
        } else {
            hit_left = x - attack_offset_right;
            hit_right = x - attack_offset_left;
        }

        var hit_top = y + attack_offset_top;
        var hit_bottom = y + attack_offset_bottom;
        var list = ds_list_create();
        collision_rectangle_list(hit_left, hit_top, hit_right, hit_bottom, obj_enemy, false, false, list, true);

        var damage_mult = 1;
        var score_mult = 1;
        if (attack_rhythm_bonus) {
            damage_mult = attack_rhythm_damage_mult;
            score_mult = score_rhythm_mult;
        }

        for (var i = 0; i < ds_list_size(list); i++) {
            var enemy = list[| i];
            scr_enemy_take_damage(enemy, attack_damage * damage_mult, dir ? attack_knock_x : -attack_knock_x, attack_knock_y);
            score += round(score_hit_base * score_mult);
        }
        ds_list_destroy(list);
    }

    if (image_index >= image_number - 1) {
        is_attacking = false;
        damage_applied = false;
        attack_rhythm_bonus = false;
        sprite_index = spr_idle;
        image_index = 0;
        image_speed = 1;
    }
} else {
    var move_input = d - a;
    var move_visual_speed = abs(hspd - knock_hspd);

    if (is_dashing) {
        sprite_index = spr_dash;
    } else if (hurt_timer > 0) {
        sprite_index = spr_hurt;
    } else if (!on_ground) {
        sprite_index = spr_jump;
    } else if (move_input != 0 || move_visual_speed > 0.2) {
        sprite_index = spr_run;
    } else {
        sprite_index = spr_idle;
    }
}

// =========================
// ДВИЖЕНИЕ ПО X
// =========================
x += hspd;
if (place_meeting(x, y, obj_wall)) {
    if (hspd != 0) {
        while (place_meeting(x, y, obj_wall)) {
            x -= sign(hspd);
        }
    }

    if (is_dashing) {
        is_dashing = false;
        dash_rhythm_invul = false;
        dash_timer = 0;
    }
    hspd = 0;
}

// =========================
// ДВИЖЕНИЕ ПО Y
// =========================
y += vspd;
if (place_meeting(x, y, obj_wall)) {
    if (vspd != 0) {
        while (place_meeting(x, y, obj_wall)) {
            y -= sign(vspd);
        }
    }
    vspd = 0;
}
