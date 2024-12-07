//feather ignore all
hor_input = 0;
key_run = false;
key_jump = false;
key_attack = false;

hsp = 0;
vsp = 0;
move_spd = 7;
jump_speed = 20;
grav = 0.7;
grounded = false;

collision_and_move = function() {
	if place_meeting(x + hsp, y, obj_wall) {
		repeat(ceil(abs(hsp))) {
			if !place_meeting(x + sign(hsp), y, obj_wall) {
				x += sign(hsp);	
			}
		}
		hsp = 0;
	}
	x += hsp;
	if place_meeting(x, y + vsp, obj_wall) {
		repeat(ceil(abs(vsp))) {
			if !place_meeting(x, y + sign(vsp), obj_wall) {
				y += sign(vsp);	
			}
		}
		vsp = 0;
	}
	y += vsp;
	grounded = place_meeting(x, y + 1, obj_wall);
}

idle = new create_state();
idle.enter = function() {
	animation_change(sprKnight_Idle_Bow);
	hsp = 0;
}
idle.step = function() {
	collision_and_move();
	if !grounded {
		change_state(falling);
		exit;
	}
	if key_attack {
		change_state(shoot);
		exit;
	}
	if hor_input != 0 {
		change_state(walk);	
		exit;
	}
	if key_jump {
		change_state(jump);
	}
}

walk = new create_state();
walk.enter = function() {
	animation_change(sprKnight_Walk_Bow);	
}
walk.step = function() {
	hsp = hor_input * move_spd;
	collision_and_move();
	
	if !grounded {
		change_state(falling);
		exit;
	}
	if key_attack {
		change_state(shoot);
		exit;
	}
	if key_jump {
		change_state(jump);
		exit;
	}
	if key_run {
		change_state(run);
		exit;
	}
	
	if hor_input == 0 {
		change_state(idle);	
	}
}

run = new create_state();
run.enter = function() {
	animation_change(sprKnight_Run_Bow);
}
run.step = function() {
	hsp = hor_input * (move_spd * 1.5);
	collision_and_move();
	
	if !grounded {
		change_state(falling);
		exit;
	}
	if key_attack {
		change_state(shoot);
		exit;
	}
	if key_jump {
		change_state(jump);
		exit;
	}
	if hor_input == 0 {
		change_state(idle);	
		exit;
	}
	if !key_run {
		change_state(walk);	
	}
}

jump = new create_state();
jump.enter = function() {
	animation_change(sprKnight_Jump_Up_Bow, 0, false);
	animation_queue_add(sprKnight_Jump_Airborne_Bow, true);
	animation_effect_squash_and_strech(30, 0.4, false, animation_curve_bounce_twice, true);
	vsp = -jump_speed;
}
jump.step = function() {
	hsp = hor_input * move_spd;
	vsp += grav;
	collision_and_move();
	if grounded {
		change_state(idle);	
		exit;
	}	
	if vsp > 0 {
		change_state(falling);
	}	
}

falling = new create_state();
falling.enter = function() {
	animation_change(sprKnight_Jump_Airborne_Bow);	
}
falling.step = function() {
	hsp = hor_input * move_spd;
	vsp += grav;
	collision_and_move();
	if grounded {
		change_state(idle);	
	}	
}

shoot = new create_state();
shoot.enter = function() {
	animation_change(sprKnight_Attack_Bow, 0, false);
}

shoot.step = function() {
	if animation_enter_frame(4)	{
		var _arrow =  instance_create_layer(x, y, "Projectiles", obj_arrow);
		if anim.image_xscale < 0 {
			_arrow.dir = 180;
			_arrow.image_angle = 180;
		}
	}
	if animation_finished() {
		change_state(idle);	
	}
}

state = idle;
anim = animation_start(sprKnight_Idle_Bow);

sprite_prefetch_multi([sprKnight_Jump_Airborne_Bow, sprKnight_Jump_Up_Bow, sprKnight_Walk_Bow, sprKnight_Idle_Bow]);