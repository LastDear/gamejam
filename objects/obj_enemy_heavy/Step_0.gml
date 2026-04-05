var player = instance_nearest(x, y, obj_player);
if (slam_cooldown > 0) slam_cooldown--;
if (action_anim_timer > 0) action_anim_timer--;

var on_ground = place_meeting(x, y + 1, obj_wall);

if (hurt_timer > 0) {
    hspd = 0;
} else {
    var dist = 99999;
    var dx = 0;
    if (instance_exists(player)) {
        dx = player.x - x;
        dist = abs(dx);
        if (dx != 0) attack_dir = sign(dx);
    }
    if (attack_dir == 0) attack_dir = move_dir;

    switch (state) {
        case "move":
            if (instance_exists(player) && dist <= aggro_range) {
                move_dir = attack_dir;
            }

            var front_x = x + move_dir * edge_check_dist;
            var wall_ahead = place_meeting(front_x, y, obj_wall);
            var ground_ahead = place_meeting(front_x, y + 2, obj_wall);

            if (wall_ahead || !ground_ahead) {
                move_dir *= -1;
            }

            hspd = move_dir * move_speed_enemy;

            if (instance_exists(player) && dist <= 200 && slam_cooldown <= 0 && on_ground) {
                state = "slam";
                slam_hit_done = false;
                hspd = 0;
                image_index = 0;
                image_speed = 1;
                action_anim_timer = action_anim_time;
            }
            break;

        case "slam":
            hspd = 0;
            image_speed = 1;
            action_anim_timer = action_anim_time;

            if (!slam_hit_done && image_index >= max(0, image_number - 1)) {
                slam_hit_done = true;
                slam_cooldown = slam_cooldown_max;
                state = "recover";
                state_timer = slam_recover_max;

                effect_create_above(ef_ring, x, bbox_bottom, 1, c_orange);
                for (var d = 16; d <= slam_particle_dist; d += 16) {
                    effect_create_above(ef_spark, x + d, bbox_bottom, 1, c_yellow);
                    effect_create_above(ef_spark, x - d, bbox_bottom, 1, c_yellow);
                    effect_create_above(ef_smoke, x + d, bbox_bottom, 1, c_orange);
                    effect_create_above(ef_smoke, x - d, bbox_bottom, 1, c_orange);
                }

                if (instance_exists(player)) {
                    var hit_dist = abs(player.x - x);
                    var hit_height = abs(player.y - y);
                    if (hit_dist <= slam_radius && hit_height <= 72) {
                        var knock_x = contact_knock_x * sign(player.x - x);
                        if (knock_x == 0) knock_x = contact_knock_x * attack_dir;
                        scr_player_take_damage(player, contact_damage + 6, knock_x, contact_knock_y);
                    }
                }
            }
            break;

        case "recover":
            hspd = 0;
            state_timer--;
            if (state_timer <= 0) {
                state = "move";
            }
            break;
    }
}

if (!on_ground) vspd += grav_acc;
vspd = clamp(vspd, -100, max_fall_speed);

if (hspd > 0) image_xscale = -1;
else if (hspd < 0) image_xscale = 1;
else if (attack_dir > 0) image_xscale = -1;
else if (attack_dir < 0) image_xscale = 1;

image_yscale = (state == "slam" && !slam_hit_done) ? 0.92 : 1;

x += hspd;
if (place_meeting(x, y, obj_wall)) {
    if (hspd != 0) {
        while (place_meeting(x, y, obj_wall)) {
            x -= sign(hspd);
        }
    }
    hspd = 0;
    move_dir *= -1;
}

y += vspd;
if (place_meeting(x, y, obj_wall)) {
    if (vspd != 0) {
        while (place_meeting(x, y, obj_wall)) {
            y -= sign(vspd);
        }
    }
    vspd = 0;
}

if (state != "slam" && place_meeting(x, y, obj_player)) {
    var hit_player = instance_place(x, y, obj_player);
    if (hit_player != noone) {
        var knock_x = contact_knock_x * sign(hit_player.x - x);
        if (knock_x == 0) knock_x = contact_knock_x * move_dir;
        scr_player_take_damage(hit_player, contact_damage, knock_x, contact_knock_y);
    }
}

event_inherited();

if (hurt_timer > 0) {
    sprite_index = spr_damaged;
    image_speed = 1;
} else if (state == "slam") {
    sprite_index = spr_hit;
    image_speed = 1;
} else {
    sprite_index = spr_run;
    image_speed = 1;
}
