var player = instance_nearest(x, y, obj_player);
if (attack_cooldown > 0) attack_cooldown--;
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
        attack_dir = sign(dx);
        if (attack_dir == 0) attack_dir = move_dir;
    }

    switch (state) {
        case "chase":
            move_dir = attack_dir;
            var front_x = x + move_dir * edge_check_dist;
            var wall_ahead = place_meeting(front_x, y, obj_wall);
            var ground_ahead = place_meeting(front_x, y + 2, obj_wall);
            if (wall_ahead || !ground_ahead) move_dir *= -1;
            hspd = move_dir * move_speed_enemy;

            if (instance_exists(player) && attack_cooldown <= 0) {
                if (dist < 300) {
                    state = choose("slam_windup", "jump_windup");
                } else {
                    state = choose("jump_windup", "charge_windup", "charge_windup");
                }
                state_timer = 18;
                hspd = 0;
                action_anim_timer = action_anim_time;
                if (state == "slam_windup") {
                    slam_hit_done = false;
                    image_index = 0;
                }
            }
            break;

        case "jump_windup":
            hspd = 0;
            state_timer--;
            action_anim_timer = action_anim_time;
            if (state_timer <= 0) {
                state = "jump_attack";
                landed_attack = false;
                hspd = attack_dir * jump_hspd;
                vspd = jump_vspd;
            }
            break;

        case "jump_attack":
            if (on_ground && vspd >= 0 && !landed_attack) {
                landed_attack = true;
                state = "recover";
                state_timer = 22;
                action_anim_timer = action_anim_time;
                effect_create_above(ef_ring, x, bbox_bottom, 2, c_red);
                effect_create_above(ef_smoke, x, bbox_bottom, 2, c_gray);
                with (obj_player) {
                    var d = point_distance(other.x, other.y, x, y);
                    if (d <= other.jump_land_radius) {
                        scr_player_take_damage(id, other.jump_damage, sign(x - other.x) * 10, -6);
                    }
                }
                attack_cooldown = attack_cooldown_max;
                hspd = 0;
            }
            break;

        case "charge_windup":
            hspd = 0;
            state_timer--;
            if (state_timer <= 0) {
                state = "charge_attack";
                state_timer = charge_time_max;
                hspd = attack_dir * charge_speed;
            }
            break;

        case "charge_attack":
            hspd = attack_dir * charge_speed;
            state_timer--;
            if (state_timer <= 0) {
                state = "recover";
                state_timer = 18;
                attack_cooldown = attack_cooldown_max;
                hspd = 0;
            }
            break;

        case "slam_windup":
            hspd = 0;
            state_timer--;
            action_anim_timer = action_anim_time;
            if (state_timer <= 0) {
                state = "slam_attack";
                slam_hit_done = false;
                image_index = 0;
                image_speed = 1;
            }
            break;

        case "slam_attack":
            hspd = 0;
            image_speed = 1;
            if (!slam_hit_done && image_index >= max(0, image_number - 2)) {
                slam_hit_done = true;
                effect_create_above(ef_ring, x + attack_dir * 44, bbox_bottom, 1, c_red);
                for (var d = 24; d <= slam_range; d += 18) {
                    effect_create_above(ef_spark, x + attack_dir * d, bbox_bottom, 1, c_red);
                    effect_create_above(ef_smoke, x + attack_dir * d, bbox_bottom, 1, c_orange);
                }
                if (instance_exists(player)) {
                    var in_front = (attack_dir > 0 && player.x >= x) || (attack_dir < 0 && player.x <= x);
                    if (in_front && abs(player.x - x) <= slam_range && abs(player.y - y) <= slam_height) {
                        scr_player_take_damage(player, slam_damage, sign(player.x - x) * 12, -6);
                    }
                }
                attack_cooldown = attack_cooldown_max;
            }
            if (slam_hit_done && image_index >= max(0, image_number - 1)) {
                state = "recover";
                state_timer = 18;
                hspd = 0;
            }
            break;

        case "recover":
            hspd = 0;
            state_timer--;
            if (state_timer <= 0) state = "chase";
            break;
    }
}

if (!on_ground) vspd += grav_acc;
vspd = clamp(vspd, -100, max_fall_speed);

if (hspd > 0) image_xscale = -1;
else if (hspd < 0) image_xscale = 1;
else if (attack_dir > 0) image_xscale = -1;
else if (attack_dir < 0) image_xscale = 1;

x += hspd;
if (place_meeting(x, y, obj_wall)) {
    if (hspd != 0) {
        while (place_meeting(x, y, obj_wall)) x -= sign(hspd);
    }
    if (state == "charge_attack") {
        state = "recover";
        state_timer = 16;
        attack_cooldown = attack_cooldown_max;
    }
    hspd = 0;
    move_dir *= -1;
}

y += vspd;
if (place_meeting(x, y, obj_wall)) {
    if (vspd != 0) {
        while (place_meeting(x, y, obj_wall)) y -= sign(vspd);
    }
    vspd = 0;
}

if ((state == "chase" || state == "charge_attack") && place_meeting(x, y, obj_player)) {
    var hit_player = instance_place(x, y, obj_player);
    if (hit_player != noone) {
        var dmg = contact_damage;
        var kx = contact_knock_x * sign(hit_player.x - x);
        if (state == "charge_attack") dmg = charge_damage;
        if (kx == 0) kx = contact_knock_x * attack_dir;
        scr_player_take_damage(hit_player, dmg, kx, contact_knock_y);
    }
}

event_inherited();

if (hurt_timer > 0) {
    sprite_index = spr_damaged;
    image_speed = 1;
} else if (state == "jump_attack") {
    sprite_index = spr_jump;
    image_speed = 1;
} else if (state == "charge_windup" || state == "charge_attack") {
    sprite_index = spr_run;
    image_speed = 1;
} else if (state == "slam_windup" || state == "slam_attack") {
    sprite_index = spr_hit;
    image_speed = 1;
} else if (abs(hspd) > 0.2) {
    sprite_index = spr_walk;
    image_speed = 1;
} else {
    sprite_index = spr_idle;
    image_speed = 1;
}
