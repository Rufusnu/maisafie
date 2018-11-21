extends KinematicBody2D

# Exports go here

export (PackedScene) var BULLET
export (PackedScene) var MELEE

# Consts go here
## physics
const UP = Vector2(-1, 0)

const GRAVITY = 15
const MAX_MOVEMENT_SPEED = 200
const MAX_FALL_SPEED = 400
const MAX_JUMP_SPEED = 400

## player
const ACCEL = 15
const DECEL = 25

const MAX_HEALTH = 300

# Vars go here

var health
var ammo


var on_floor
var on_wall
var on_ceiling

var faceing_right = true
var movement = Vector2()
var speed = 0

func _ready():
	pass

func _physics_process(delta):
	
	on_floor = is_on_wall()
	on_wall = is_on_wall()
	on_ceiling = is_on_ceiling()
	
	movement.y += GRAVITY
	if movement.y > MAX_FALL_SPEED:
		movement.y = MAX_FALL_SPEED
	
	if on_floor and movement.y > 10:
		movement.y = 10
	
	if on_ceiling and movement.y < -15:
		movement.y += GRAVITY
	
	
	
	if Input.is_action_pressed("ui_right"):
		speed += ACCEL
		faceing_right = true
	
	if Input.is_action_pressed("ui_left"):
		speed -= ACCEL
		faceing_right = false
		
	speed = min(speed, MAX_MOVEMENT_SPEED)
	speed = max(speed, -MAX_MOVEMENT_SPEED)
	
	if on_floor and Input.is_action_just_pressed("ui_up"):
		movement.y -= MAX_JUMP_SPEED
	
	if on_floor:
		if !Input.is_action_pressed("ui_right") and !Input.is_action_pressed("ui_left"):
			speed = lerp(speed, 0, 0.2)
	else:
		speed = lerp(speed, 0, 0.05)
	
	movement.x = speed
	
	move_and_slide(movement, UP)
	
	$texture.flip_h = faceing_right
	
	if Input.is_action_just_pressed("ui_shoot"):
		shoot()
	
	if Input.is_action_just_pressed("ui_melee"):
		melee()


func shoot():
	var dist = 40
	var poz = position
	var rot = 0
	
	if !faceing_right:
		dist = -dist
		rot = PI
	poz.x += dist
	
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet.setup(poz, rot)
	
func melee():
	var dist = 20
	if !faceing_right:
		dist = -dist
	
	var melee = MELEE.instance()
	
	add_child(melee)
	
	