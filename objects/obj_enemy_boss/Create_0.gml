event_inherited();

hp = 320;
weight = 3.0;
ignore_knockback = true;
move_dir = 1;
move_speed_enemy = 1.6;
edge_check_dist = 22;

contact_damage = 18;
contact_knock_x = 10;
contact_knock_y = -5;

attack_cooldown_max = 75;
attack_cooldown = 45;
state = "chase";
state_timer = 0;
attack_dir = 1;

jump_damage = 24;
jump_hspd = 4.6;
jump_vspd = -9.5;
jump_land_radius = 200;

charge_damage = 20;
charge_speed = 8.5;
charge_time_max = 24;

slam_damage = 28;
slam_range =200;
slam_height = 100;
slam_hit_done = false;

landed_attack = false;
action_anim_timer = 0;
action_anim_time = 12;

spr_idle = spr_boss_idle;
spr_walk = spr_boss_walk;
spr_run = spr_boss_run;
spr_jump = spr_boss_jump;
spr_hit = spr_boss_hit;
spr_damaged = spr_boss_damaged;
sprite_index = spr_idle;
image_speed = 1;
