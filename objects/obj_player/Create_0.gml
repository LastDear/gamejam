move_speed = 4.0;

hspd = 0;
vspd = 0;

grav_acc = 0.35;
max_fall_speed = 8;
jump_speed = -12;

dir = true;

// =========================
// СПРАЙТЫ / ВИЗУАЛЬНЫЕ ПАКИ
// =========================
style_mode = 2; // 1 = старые, 2 = новые

spr_idle = Sprite1;
spr_run = Sprite3;
spr_jump = Sprite1;
spr_dash = Sprite1;
spr_hurt = Sprite1;
spr_attack = spr_b_player_hit;

// =========================
// АТАКА
// =========================
is_attacking = false;
attack_cooldown = false;
damage_applied = false;
attack_rhythm_bonus = false;


attack_rhythm_damage_mult = 1.20;

attack_hit_frame = 0;
attack_damage = 25;

attack_knock_x = 10;
attack_knock_y = -2;

attack_anim_speed = 0.35;
attack_cooldown_time = 0.3; // в секундах

// =========================
// DASH
// =========================
is_dashing = false;
dash_timer = 0;
dash_cooldown = 0;
dash_hspd = 0;

dash_speed = 11;
dash_time = 7;
dash_cooldown_time = 30;

dash_rhythm_speed_bonus = 4;
dash_rhythm_time_bonus = 4;
dash_rhythm_invul = false;

// =========================
// ХИТБОКС АТАКИ
// все значения относительно игрока
// =========================
attack_offset_left = 20;
attack_offset_right = 140;

attack_offset_top = -140;
attack_offset_bottom = 10;

// =========================
// ДЕБАГ ОТРИСОВКИ
// =========================
debug_draw_attack_hitbox = true;

// =========================
// ПОЛУЧЕНИЕ УРОНА
// =========================
max_hp = 100;
hp = max_hp;
hurt_timer = 0;
hurt_time = 18;
knock_hspd = 0;
knock_friction = 0.82;
invulnerable_timer = 0;

// =========================
// РИТМ И ОЧКИ
// =========================
rhythm_bpm = 50;
rhythm_interval = room_speed * 60 / rhythm_bpm;
rhythm_timer = 0;
rhythm_window = 6;
rhythm_feedback_timer = 0;
rhythm_feedback_text = "";
last_rhythm_success = false;

score = 0;
score_hit_base = 100;
score_rhythm_mult = 1.20;
