x += lengthdir_x(speed, dir);
y += lengthdir_y(speed, dir);

life--;
if (life <= 0) instance_destroy();

// если есть объект стен
if (place_meeting(x, y, obj_wall)) {
    instance_destroy();
}

// попадание в игрока
if (place_meeting(x, y, obj_player)) {
    var pl = instance_place(x, y, obj_player);
    if (pl != noone) {
        // если у игрока есть hp
        if (variable_instance_exists(pl, "hp")) {
            pl.hp -= damage;
        }
    }
    instance_destroy();
}