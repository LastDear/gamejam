base_move_speed = 6.0;
base_jump_speed = -13;
base_attack_damage = 25;
base_attack_knock_x = 10;
base_attack_knock_y = -2;
base_attack_anim_speed = 1;
base_attack_cooldown_time = 0.3;
base_max_hp = 100;
base_dash_speed = 13;
base_dash_time = 10;
base_dash_cooldown_time = 100;
base_dash_rhythm_speed_bonus = 4;
base_dash_rhythm_time_bonus = 4;
base_rhythm_window = 4;
base_attack_rhythm_damage_mult = 1.20;
base_score_rhythm_mult = 1.20;
base_grav_acc = 0.35;
base_max_fall_speed = 8;

move_speed = base_move_speed;

hspd = 0;
vspd = 0;

grav_acc = base_grav_acc;
max_fall_speed = base_max_fall_speed;
jump_speed = base_jump_speed;

dir = true;

stance_mode = 2; // 1 = Harder, 2 = Better, 3 = Faster, 4 = Stronger
stance_name = "";
stance_color = c_white;
damage_taken_mult = 1.0;

spr_idle = Sprite1;
spr_run = Sprite3;
spr_jump = Sprite1;
spr_dash = Sprite1;
spr_hurt = Sprite1;
spr_attack = Sprite_Attack;

is_attacking = false;
attack_cooldown = false;
damage_applied = false;
attack_rhythm_bonus = false;

attack_rhythm_damage_mult = base_attack_rhythm_damage_mult;

attack_hit_frame = 2;
attack_damage = base_attack_damage;

attack_knock_x = base_attack_knock_x;
attack_knock_y = base_attack_knock_y;

attack_anim_speed = base_attack_anim_speed;
attack_cooldown_time = base_attack_cooldown_time;

is_dashing = false;
dash_timer = 0;
dash_cooldown = 0;
dash_hspd = 0;

dash_speed = base_dash_speed;
dash_time = base_dash_time;
dash_cooldown_time = base_dash_cooldown_time;

dash_rhythm_speed_bonus = base_dash_rhythm_speed_bonus;
dash_rhythm_time_bonus = base_dash_rhythm_time_bonus;
dash_rhythm_invul = false;

attack_offset_left = 20;
attack_offset_right = 140;
attack_offset_top = -140;
attack_offset_bottom = 10;

debug_draw_attack_hitbox = false;
attack_fx_color = c_white;

max_hp = base_max_hp;
hp = max_hp;
hurt_timer = 0;
hurt_time = 45;
knock_hspd = 0;
knock_friction = 0.82;
invulnerable_timer = 0;

rhythm_bpm = 120;
rhythm_interval = room_speed * 60 / rhythm_bpm;
rhythm_timer = 13;
rhythm_window = base_rhythm_window;
rhythm_feedback_timer = 0;
rhythm_feedback_text = "";
last_rhythm_success = false;

score = 0;
score_hit_base = 100;
score_rhythm_mult = base_score_rhythm_mult;

stance_switch_cooldown_time = 200;
stance_switch_cooldown = 0;
stance_switch_bonus_time = room_speed * 6;
stance_switch_bonus_timer = 0;
stance_switch_bonus_damage_mult = 1.25;
stance_switch_bonus_move_mult = 1.20;
stance_switch_bonus_score_mult = 1.50;
stance_switch_bonus_active = false;


camera_follow_lerp = 0.8;
parallax_x_factor = 0.8;
parallax_y_factor = 0.08;
room1_camera_enabled = true;
