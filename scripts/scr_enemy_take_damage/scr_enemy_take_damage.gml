function scr_enemy_take_damage(_enemy, _damage, _knock_x, _knock_y)
{
    if (!instance_exists(_enemy)) return;
    //if (_enemy.hurt_timer > 0) return;

    _enemy.hp -= _damage;

    var _ignore_knock = false;
    if (variable_instance_exists(_enemy, "ignore_knockback")) {
        _ignore_knock = _enemy.ignore_knockback;
    }

    if (!_ignore_knock) {
        _enemy.hspd = _knock_x;
        _enemy.vspd = _knock_y;

        // разворачиваем врага по направлению отлёта
        if (_knock_x > 0) _enemy.move_dir = 1;
        if (_knock_x < 0) _enemy.move_dir = -1;
    } else {
        _enemy.hspd = 0;
        if (_enemy.vspd < 0) _enemy.vspd = 0;
    }

    _enemy.hurt_timer = _enemy.invul_time;
    _enemy.image_blend = c_red;

    if (_enemy.hp <= 0) {
        instance_destroy(_enemy);
    }
}
