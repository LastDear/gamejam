var player = instance_nearest(x, y, obj_player);
if (slam_cooldown > 0) slam_cooldown--;

if (hurt_timer > 0) {
    hspd *= 0.92;
}
else {
    var target_dir = move_dir;
    var dist = 99999;
    if (instance_exists(player)) {
        var dx = player.x - x;
        dist = abs(dx);
        if (dx != 0) target_dir = sign(dx);
    }

    if (slam_timer > 0) {
        slam_timer--;
        hspd = 0;
        if (slam_timer <= 0) {
            slam_cooldown = slam_cooldown_max;
        }
    }
    else {
        if (dist <= aggro_range) {
            move_dir = target_dir;
        }

        var front_x = x + move_dir * edge_check_dist;
        var wall_ahead = place_meeting(front_x, y, obj_wall);
        var ground_ahead = place_meeting(front_x, y + 2, obj_wall);

        if (wall_ahead || !ground_ahead) {
            move_dir *= -1;
        }

        hspd = move_dir * move_speed_enemy;

        if (instance_exists(player) && dist <= 72 && slam_cooldown <= 0) {
            slam_timer = slam_windup_max;
            hspd = 0;
        }
    }
}

var on_ground = place_meeting(x, y + 1, obj_wall);
if (!on_ground) vspd += grav_acc;
vspd = clamp(vspd, -100, max_fall_speed);

if (hspd > 0) image_xscale = 1;
else if (hspd < 0) image_xscale = -1;

image_yscale = (slam_timer > 0) ? 0.92 : 1;

x += hspd;
if (place_meeting(x, y, obj_wall)) {
    while (place_meeting(x, y, obj_wall)) {
        x -= sign(hspd);
    }
    hspd = 0;
    move_dir *= -1;
}

y += vspd;
if (place_meeting(x, y, obj_wall)) {
    while (place_meeting(x, y, obj_wall)) {
        y -= sign(vspd);
    }
    vspd = 0;
}

if (place_meeting(x, y, obj_player)) {
    var hit_player = instance_place(x, y, obj_player);
    if (hit_player != noone) {
        var bonus_damage = (slam_timer > 0) ? 6 : 0;
        var knock_mult = (slam_timer > 0) ? 1.35 : 1;
        var knock_x = contact_knock_x * knock_mult * sign(hit_player.x - x);
        if (knock_x == 0) knock_x = contact_knock_x * knock_mult * move_dir;
        scr_player_take_damage(hit_player, contact_damage + bonus_damage, knock_x, contact_knock_y);
    }
}

event_inherited();
