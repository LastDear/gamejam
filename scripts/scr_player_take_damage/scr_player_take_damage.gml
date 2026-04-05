function scr_player_take_damage(_player, _damage, _knock_x, _knock_y)
{
    if (!instance_exists(_player)) return;
    if (_player.hurt_timer > 0) return;
    if (_player.invulnerable_timer > 0) return;

    var final_damage = _damage;
    if (variable_instance_exists(_player, "damage_taken_mult")) {
        final_damage *= _player.damage_taken_mult;
    }

    _player.hp -= final_damage;
    _player.hurt_timer = _player.hurt_time;
    _player.image_blend = c_red;

    _player.knock_hspd += _knock_x;
    _player.vspd = min(_player.vspd, _knock_y);

    if (_player.hp <= 0) {
        room_restart();
    }
}
