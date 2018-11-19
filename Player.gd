extends KinematicBody2D

# Exports go here


# Consts go here
## physics
const UP = Vector2(-1, 0)

const GRAVITY = 15
const MAX_MOVEMENT_SPEED = 200
const MAX_FALL_SPEED = 250
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
	elif speed > DECEL:
		speed -= DECEL
	elif !Input.is_action_pressed("ui_left"):
		 speed = 0
	
	if Input.is_action_pressed("ui_left"):
		speed -= ACCEL
	elif speed < -DECEL:
		speed += DECEL
	elif !Input.is_action_pressed("ui_right"):
		speed = 0
		
	if speed > MAX_MOVEMENT_SPEED:
		speed = MAX_MOVEMENT_SPEED
	elif speed < -MAX_MOVEMENT_SPEED:
		speed = -MAX_MOVEMENT_SPEED
	
	print(on_floor)
	if on_floor and Input.is_action_just_pressed("ui_up"):
		movement.y -= MAX_JUMP_SPEED
	
	movement.x = speed
	
	move_and_slide(movement, UP)
	