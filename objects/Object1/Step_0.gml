//проверяем нажата ли А?
a = keyboard_check(ord("A"));

//проверяем нажата ли D?
d = keyboard_check(ord("D"));

//проверяем нажат ли пробел?
space = keyboard_check(vk_space);

// вычисляем горизонтальную скорость
hspd = (d - a) * move_speed;




if (place_meeting(x, y + sprite_height/2 + 1, obj_wall)) {
    if (space) {
        vspd = jump_power;
    }
} else {
    vspd += player_gravity;
}

// Передвигаем игрока
move_and_collide(hspd, vspd, obj_wall, 4, 0, 0, move_speed, jump_power)

// если координата по х мыши не равна
if (x != mouse_x){
// то зеркалим игрока в нужную сторону
image_xscale = sign(mouse_x - x)
}