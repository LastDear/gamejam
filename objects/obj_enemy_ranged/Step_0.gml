var player = instance_nearest(x, y, obj_player);

if (hurt_timer <= 0) {
    hspd = 0;

    if (instance_exists(player)) {
        var dx = player.x - x;
        var dist = abs(dx);
        var face_dir = sign(dx);
        if (face_dir == 0) face_dir = image_xscale;

        // Разворот в сторону игрока
        if (face_dir > 0) {
            image_xscale = 1;
        } else if (face_dir < 0) {
            image_xscale = -1;
        }

        // Держим дистанцию: отходим, если игрок близко; подходим, если слишком далеко
        var move_intent = 0;
        if (dist < retreat_distance) {
            move_intent = -face_dir;
        }
        else if (dist > preferred_distance && dist < attack_range * 1.25) {
            move_intent = face_dir;
        }

        if (move_intent != 0) {
            var front_x = x + move_intent * edge_check_dist;
            var wall_ahead = place_meeting(front_x, y, obj_wall);
            var ground_ahead = place_meeting(front_x, y + 2, obj_wall);

            if (!wall_ahead && ground_ahead) {
                hspd = move_intent * move_speed_enemy;
            }
        }

        // Стрельба только если игрок в зоне и между ними нет стены
        shoot_cooldown--;
        var fire_y = y + fire_offset_y;
        var target_y = player.y - 2;
        var blocked = collision_line(x, fire_y, player.x, target_y, obj_wall, false, true);

        if (dist <= attack_range && shoot_cooldown <= 0 && blocked == noone) {
            var spawn_x = x + image_xscale * fire_offset_x;
            var spawn_y = fire_y;
            var dir_angle = point_direction(spawn_x, spawn_y, player.x, target_y);

            var bullet = instance_create_layer(spawn_x, spawn_y, "Instances", obj_enemy_projectile);
            bullet.hspd = lengthdir_x(projectile_speed, dir_angle);
            bullet.vspd = lengthdir_y(projectile_speed, dir_angle);
            bullet.image_angle = dir_angle;

            shoot_cooldown = shoot_cooldown_max;
        }
    }
}
else {
    hspd *= 0.90;
}

// Гравитация / платформа
var on_ground = place_meeting(x, y + 1, obj_wall);
if (!on_ground) {
    vspd += grav_acc;
}

vspd = clamp(vspd, -100, max_fall_speed);

x += hspd;
if (place_meeting(x, y, obj_wall)) {
    while (place_meeting(x, y, obj_wall)) {
        x -= sign(hspd);
    }
    hspd = 0;
}

y += vspd;
if (place_meeting(x, y, obj_wall)) {
    while (place_meeting(x, y, obj_wall)) {
        y -= sign(vspd);
    }
    vspd = 0;
}

event_inherited();
