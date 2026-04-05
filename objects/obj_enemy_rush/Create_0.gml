event_inherited();

hp = 75;
weight = 0.9;
move_dir = 1;

patrol_speed = 2.6;
charge_speed = 7.5;
edge_check_dist = 18;
detection_range = 260;
charge_windup_max = 12;
charge_duration_max = 20;
charge_cooldown_max = 45;

charge_windup = 0;
charge_duration = 0;
charge_cooldown = irandom_range(10, 25);
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
