event_inherited();

hp = 100;
weight = 0.9;
move_dir = 1;

patrol_speed = 2.6;
charge_speed = 6;
edge_check_dist = 18;
detection_range = 260;
charge_windup_max = 12;
charge_duration_max = 20;
charge_cooldown_max = 45;

charge_windup = 0;
charge_duration = 0;
charge_cooldown = 120;
charge_dir = 1;
is_charging = false;

spr_run = spr_cook_run;
spr_hit = spr_cook_hit;
spr_damaged = spr_cook_damaged;
sprite_index = spr_run;
image_speed = 1;

contact_damage = 14;
contact_knock_x = 9;
contact_knock_y = -5;

action_anim_timer = 0;
action_anim_time = 8;
