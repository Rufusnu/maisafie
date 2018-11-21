extends KinematicBody2D

export (int) var HEALTH
const MAX_SPEED = 100
const ACCEL = 20

const GRAVITY = 15
const MAX_FALL_SPEED = 400
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var hp 
var movement = Vector2()
var to_follow = null

func _ready():
	hp = HEALTH

func _physics_process(delta):
	movement.y = min(movement.y + GRAVITY, MAX_FALL_SPEED)
	if is_on_floor():
		movement.y = min(10, movement.y)
	
	if hp <= 0:
		die()
	if to_follow != null and is_on_floor():
		move(to_follow)
	if movement.y < 10:
		print(movement.y)
	move_and_slide(movement, Vector2(0, -1))

func move(body):
	if body.position.x > position.x:
		movement.x = min(movement.x + ACCEL, MAX_SPEED)
		$Sprite.flip_h = true
	else:
		movement.x = max(movement.x - ACCEL, -MAX_SPEED)
		$Sprite.flip_h = false
		
func stop():
	movement.x = 0

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		to_follow = body

func _on_Area2D_body_exited(body):
	if body.name == "Player":
		to_follow = null
		stop()

func take_damage(damage):
	hp -= damage
	print("Auch!")
	
func knock(mov):
	print("knock")
	movement += mov

func die():
	queue_free()

