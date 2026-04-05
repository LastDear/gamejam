var player = instance_nearest(x, y, obj_player);

if (charge_cooldown > 0) charge_cooldown--;
if (hurt_timer > 0) {
    hspd *= 0.90;
    if (charge_windup > 0) charge_windup = 0;
    is_charging = false;
    charge_duration = 0;
}
else {
    var target_seen = false;
    if (instance_exists(player)) {
        var dx = player.x - x;
        var dy = abs(player.y - y);
        if (abs(dx) <= detection_range && dy <= 64) {
            target_seen = true;
            charge_dir = sign(dx);
            if (charge_dir == 0) charge_dir = move_dir;
        }
    }

    if (is_charging) {
        action_anim_timer = action_anim_time;
        hspd = charge_dir * charge_speed;
        charge_duration--;
        if (charge_duration <= 0) {
            is_charging = false;
            charge_cooldown = charge_cooldown_max;
        }
    }
    else if (charge_windup > 0) {
        hspd = 0;
        action_anim_timer = action_anim_time;
        charge_windup--;
        if (charge_windup <= 0) {
            is_charging = true;
            charge_duration = charge_duration_max;
        }
    }
    else if (target_seen && charge_cooldown <= 0) {
        hspd = 0;
        charge_windup = charge_windup_max;
    }
    else {
        var front_x = x + move_dir * edge_check_dist;
        var wall_ahead = place_meeting(front_x, y, obj_wall);
        var ground_ahead = place_meeting(front_x, y + 2, obj_wall);

        if (wall_ahead || !ground_ahead) {
            move_dir *= -1;
        }

        hspd = move_dir * patrol_speed;
    }
}

var on_ground = place_meeting(x, y + 1, obj_wall);
if (!on_ground) vspd += grav_acc;
vspd = clamp(vspd, -100, max_fall_speed);

if (hspd > 0) image_xscale = -1;
else if (hspd < 0) image_xscale = 1;

x += hspd;
if (place_meeting(x, y, obj_wall)) {
    while (place_meeting(x, y, obj_wall)) {
        x -= sign(hspd);
    }
    if (is_charging) {
        is_charging = false;
        charge_duration = 0;
        charge_cooldown = max(charge_cooldown, charge_cooldown_max div 2);
    }
    hspd = 0;
    move_dir = -move_dir;
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
        var knock_x = contact_knock_x * sign(hit_player.x - x);
        if (knock_x == 0) knock_x = contact_knock_x * move_dir;
        scr_player_take_damage(hit_player, contact_damage, knock_x, contact_knock_y);
    }
}

event_inherited();


if (action_anim_timer > 0) action_anim_timer--;

if (hurt_timer > 0) {
    sprite_index = spr_damaged;
} else if (charge_windup > 0 || is_charging || action_anim_timer > 0) {
    sprite_index = spr_hit;
} else {
    sprite_index = spr_run;
}
