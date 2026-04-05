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

        if (_knock_x > 0) _enemy.move_dir = 1;
        if (_knock_x < 0) _enemy.move_dir = -1;
    } else {
        _enemy.hspd = 0;
        if (_enemy.vspd < 0) _enemy.vspd = 0;
    }

    _enemy.hurt_timer = _enemy.invul_time;
    _enemy.image_blend = c_red;

    var jam_main = make_color_rgb(220, 40, 70);
    var jam_light = make_color_rgb(255, 120, 150);
    effect_create_above(ef_ring, _enemy.x, _enemy.y - 16, 1, jam_main);
    for (var i = 0; i < 6; i++) {
        var px = _enemy.x + irandom_range(-20, 20);
        var py = _enemy.y + irandom_range(-32, 0);
        effect_create_above(ef_smoke, px, py, 1, choose(jam_main, jam_light));
        if (i mod 2 == 0) {
            effect_create_above(ef_spark, px, py, 1, jam_main);
        }
    }

    if (_enemy.hp <= 0) {
        for (var j = 0; j < 10; j++) {
            var kx = _enemy.x + irandom_range(-28, 28);
            var ky = _enemy.y + irandom_range(-36, 8);
            effect_create_above(ef_smoke, kx, ky, 1, choose(jam_main, jam_light));
            effect_create_above(ef_spark, kx, ky, 1, jam_main);
        }

        if (_enemy.object_index == obj_enemy_boss) {
            _enemy.hp = 0;
            _enemy.boss_dead = true;
            _enemy.boss_death_timer = room_speed * 2;
            _enemy.state = "dead";
            _enemy.hspd = 0;
            _enemy.vspd = 0;
        } else {
            instance_destroy(_enemy);
        }
    }
}
