event_inherited();

hp = 180;
weight = 2.5;
ignore_knockback = true;
move_dir = 1;
attack_dir = 1;
move_speed_enemy = 1.0;
edge_check_dist = 20;

contact_damage = 20;
contact_knock_x = 12;
contact_knock_y = -6;

aggro_range = 150;
slam_cooldown_max = 80;
slam_cooldown = 80;
slam_recover_max = 14;
state = "move";
state_timer = 0;
slam_hit_done = false;
slam_radius = 200;
slam_particle_dist = 200;

spr_run = spr_golem_run;
spr_hit = spr_golem_hit;
spr_damaged = spr_golem_damaged;
sprite_index = spr_run;
image_speed = 1;
action_anim_timer = 0;
action_anim_time = 10;
