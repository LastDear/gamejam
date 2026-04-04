// =========================
// ВВОД
// =========================
var a = keyboard_check(ord("A"));
var d = keyboard_check(ord("D"));
var k1 = keyboard_check_pressed(ord("1"));
var k2 = keyboard_check_pressed(ord("2"));
var space = keyboard_check_pressed(vk_space);
var attack = mouse_check_button_pressed(mb_left);
if (keyboard_check(ord("D"))) facing = 1;
if (keyboard_check(ord("A"))) facing = -1;


// =========================
// СМЕНА СПРАЙТА СТОЙКИ
// =========================
if (!is_attacking) {
    if (k1) spr_idle = Sprite1;
    if (k2) spr_idle = Sprite3;
}
if (dash_cooldown_timer > 0) dash_cooldown_timer--;
if (dash_timer > 0) dash_timer--;

if (keyboard_check_pressed(vk_shift) && dash_cooldown_timer <= 0 && !is_dashing) {
    if (keyboard_check(ord("D"))) dash_dir = 1;
    else if (keyboard_check(ord("A"))) dash_dir = -1;
    else dash_dir = facing;

    is_dashing = true;
    dash_timer = dash_duration;
    dash_cooldown_timer = dash_cooldown;
}

// =========================
// ДВИЖЕНИЕ
// =========================
hspd = (d - a) * move_speed;


// =========================
// ПРОВЕРКА ПОЛА
// =========================
var on_ground = place_meeting(x, y + 1, obj_wall);


// =========================
// ПРЫЖОК
// =========================
if (on_ground && space) {
    vspd = jump_speed;
}


// =========================
// СВОЯ ГРАВИТАЦИЯ
// =========================
if (!on_ground) {
    vspd += grav_acc;
}

vspd = clamp(vspd, -100, max_fall_speed);


// =========================
// ПОВОРОТ
// =========================
if (hspd > 0) {
    image_xscale = 1;
    dir = true;
}
else if (hspd < 0) {
    image_xscale = -1;
    dir = false;
}


// =========================
// СТАРТ АТАКИ
// =========================
if (attack && !is_attacking && !attack_cooldown) {
    is_attacking = true;
    attack_cooldown = true;
    damage_applied = false;

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

        for (var i = 0; i < ds_list_size(list); i++) {
            var enemy = list[| i];
            scr_enemy_take_damage(
                enemy,
                attack_damage,
                dir ? attack_knock_x : -attack_knock_x,
                attack_knock_y
            );
        }

        ds_list_destroy(list);
    }

    if (image_index >= image_number - 1) {
        is_attacking = false;
        damage_applied = false;

        sprite_index = spr_idle;
        image_index = 0;
        image_speed = 0.2;
    }
}
else {
    sprite_index = spr_idle;
}

if (is_dashing) {
    hsp = dash_dir * dash_speed;
    vsp = 0;
	vspd = 0

    if (place_meeting(x + hsp, y, obj_wall)) {
        is_dashing = false;
        hsp = 0;
    } else {
        x += hsp;
    }

    if (dash_timer <= 0) {
        is_dashing = false;
    }

    exit;
}

// =========================
// ДВИЖЕНИЕ ПО X
// =========================
x += hspd;
if (place_meeting(x, y, obj_wall)) {
    while (place_meeting(x, y, obj_wall)) {
        x -= sign(hspd);
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