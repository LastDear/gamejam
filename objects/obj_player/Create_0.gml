move_speed = 4.0;

hspd = 0;
vspd = 0;

grav_acc = 0.35;
max_fall_speed = 8;
jump_speed = -12;

dir = true;

// =========================
// СПРАЙТЫ
// =========================
spr_idle = Sprite1;
spr_attack = Sprite_Attack;

// =========================
// АТАКА
// =========================
is_attacking = false;
attack_cooldown = false;
damage_applied = false;

attack_hit_frame = 0;
attack_damage = 25;

attack_knock_x = 10;
attack_knock_y = -2;

attack_anim_speed = 0.35;
attack_cooldown_time = 0.3; // в секундах

// =========================
// ХИТБОКС АТАКИ
// все значения относительно игрока
// =========================
attack_offset_left = 10;
attack_offset_right = 50;

attack_offset_top = -50;
attack_offset_bottom = 10;

// =========================
// ДЕБАГ ОТРИСОВКИ
// =========================
debug_draw_attack_hitbox = true;
// DASH
dash_speed = 20;
dash_duration = 10;
dash_timer = 0;

dash_cooldown = 30;
dash_cooldown_timer = 0;

is_dashing = false;
dash_dir = 0;
facing = 1; // 1 = вправо, -1 = влево