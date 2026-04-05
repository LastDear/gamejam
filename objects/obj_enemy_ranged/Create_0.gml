event_inherited();

hp = 70;

move_speed_enemy = 1.4;
edge_check_dist = 18;

preferred_distance = 260;
retreat_distance = 170;
attack_range = 520;

shoot_cooldown_max = 75;
shoot_cooldown = irandom_range(20, 45);
projectile_speed = 8;

fire_offset_x = 10;
fire_offset_y = -8;

spr_run = spr_crois_run;
spr_hit = spr_crois_hit;
spr_damaged = spr_crois_damaged;
sprite_index = spr_run;
image_speed = 1;
