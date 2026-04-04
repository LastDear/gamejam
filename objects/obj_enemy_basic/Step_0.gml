// =========================
// ИИ работает только если враг не в стане от удара
// =========================
if (hurt_timer <= 0) {
    var front_x = x + move_dir * edge_check_dist;

    var wall_ahead = place_meeting(front_x, y, obj_wall);
    var ground_ahead = place_meeting(front_x, y + 2, obj_wall);

    if (wall_ahead || !ground_ahead) {
        move_dir *= -1;
    }

    hspd = move_dir * move_speed_enemy;
}
else {
    // во время получения урона не задаём hspd заново
    // можно слегка гасить скорость, чтобы отлет был мягче
    hspd *= 0.90;
}


// =========================
// ПРОВЕРКА ПОЛА
// =========================
var on_ground = place_meeting(x, y + 1, obj_wall);


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
}
else if (hspd < 0) {
    image_xscale = -1;
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
    move_dir *= -1;
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


// =========================
// КОНТАКТНЫЙ УРОН ПО ИГРОКУ
// =========================
if (place_meeting(x, y, obj_player)) {
    var player = instance_place(x, y, obj_player);
    if (player != noone) {
        var knock_x = contact_knock_x * sign(player.x - x);
        if (knock_x == 0) {
            knock_x = contact_knock_x * move_dir;
        }

        scr_player_take_damage(player, contact_damage, knock_x, contact_knock_y);
    }
}

// =========================
// ОБЩАЯ ЛОГИКА РОДИТЕЛЯ
// =========================
event_inherited();