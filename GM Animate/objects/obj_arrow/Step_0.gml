x += lengthdir_x(spd, dir);
y += lengthdir_y(spd, dir);

var _enemy = instance_place(x, y, obj_enemy);
if _enemy != noone {
	_enemy.hp -= damage;
	instance_destroy();
}

if place_meeting(x, y, obj_wall) {
	instance_destroy();	
}