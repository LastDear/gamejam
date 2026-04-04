life--;
if (life <= 0) {
    instance_destroy();
    exit;
}

x += hspd;
if (place_meeting(x, y, obj_wall)) {
    instance_destroy();
    exit;
}

y += vspd;
if (place_meeting(x, y, obj_wall)) {
    instance_destroy();
    exit;
}

var player = instance_place(x, y, obj_player);
if (instance_exists(player)) {
    scr_player_take_damage(
        player,
        damage,
        sign(hspd) * knock_x,
        knock_y
    );
    instance_destroy();
    exit;
}

if (x < -64 || x > room_width + 64 || y < -64 || y > room_height + 64) {
    instance_destroy();
}
