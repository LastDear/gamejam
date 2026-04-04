// =========================
// ВВОД
// =========================
var a = keyboard_check(ord("A"));
var d = keyboard_check(ord("D"));
var k1 = keyboard_check_pressed(ord("1"));
var k2 = keyboard_check_pressed(ord("2"));
var space = keyboard_check_pressed(vk_space);
var attack = mouse_check_button_pressed(mb_left);
var dash = keyboard_check_pressed(vk_shift);


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

if (invulnerable_timer > 0) {
    invulnerable_timer--;
}

if (dash_cooldown > 0) {
    dash_cooldown--;
}

if (rhythm_feedback_timer > 0) {
    rhythm_feedback_timer--;
}

knock_hspd *= knock_friction;
if (abs(knock_hspd) < 0.1) {
    knock_hspd = 0;
}


// =========================
// СМЕНА ВИЗУАЛЬНОГО ПАКА
// =========================
if (k1) style_mode = 1;
if (k2) style_mode = 2;

if (style_mode == 2) {
    spr_idle = spr_b_player_idle;
    spr_run = spr_b_player_run_hit;
    spr_jump = spr_b_player_jump;
    spr_dash = spr_b_player_dodge;
    spr_hurt = spr_b_player_hit;
}
else {
    spr_idle = Sprite1;
    spr_run = Sprite3;
    spr_jump = Sprite1;
    spr_dash = Sprite1;
    spr_hurt = Sprite1;
}


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
// ПРОВЕРКА ПОЛА
// =========================
var on_ground = place_meeting(x, y + 1, obj_wall);


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
}
else {
    var move_hspd = (d - a) * move_speed;
    hspd = move_hspd + knock_hspd;

    if (on_ground && space) {
        vspd = jump_speed;
    }

    if (!on_ground) {
        vspd += grav_acc;
    }

    vspd = clamp(vspd, -100, max_fall_speed);
}


// =========================
// ПОВОРОТ
// =========================
if (!is_dashing) {
    if (hspd > 0) {
        image_xscale = 1;
        dir = true;
    }
    else if (hspd < 0) {
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
            hit_left  = x + attack_offset_left;
            hit_right = x + attack_offset_right;
        } else {
            hit_left  = x - attack_offset_right;
            hit_right = x - attack_offset_left;
        }

        var hit_top = y + attack_offset_top;
        var hit_bottom = y + attack_offset_bottom;

        var list = ds_list_create();

        collision_rectangle_list(
            hit_left,
            hit_top,
            hit_right,
            hit_bottom,
            obj_enemy,
            false,
            false,
            list,
            true
        );

        var damage_mult = 1;
        var score_mult = 1;
        if (attack_rhythm_bonus) {
            damage_mult = attack_rhythm_damage_mult;
            score_mult = score_rhythm_mult;
        }

        for (var i = 0; i < ds_list_size(list); i++) {
            var enemy = list[| i];
            scr_enemy_take_damage(
                enemy,
                attack_damage * damage_mult,
                dir ? attack_knock_x : -attack_knock_x,
                attack_knock_y
            );

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
        image_speed = 0.2;
    }
}
else {
    var move_input = d - a;
    var move_visual_speed = abs(hspd - knock_hspd);

    if (is_dashing) {
        sprite_index = spr_dash;
        image_speed = 0.35;
    }
    else if (hurt_timer > 0) {
        sprite_index = spr_hurt;
        image_speed = 0.20;
    }
    else if (!on_ground) {
        sprite_index = spr_jump;
        image_speed = 0.18;
    }
    else if (move_input != 0 || move_visual_speed > 0.2) {
        sprite_index = spr_run;
        image_speed = 0.30;
    }
    else {
        sprite_index = spr_idle;
        image_speed = 0.20;
    }
}


// =========================
// ДВИЖЕНИЕ ПО X
// =========================
x += hspd;
if (place_meeting(x, y, obj_wall)) {
    while (place_meeting(x, y, obj_wall)) {
        x -= sign(hspd);
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
    while (place_meeting(x, y, obj_wall)) {
        y -= sign(vspd);
    }
    vspd = 0;
}
