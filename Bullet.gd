extends KinematicBody2D

export (int) var DAMAGE
export (int) var SPEED

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _physics_process(delta):
	var body = move_and_collide(Vector2(SPEED, 0).rotated(rotation) * delta) 
	
	if body:
		if body.collider.has_method("take_damage"):
			body.collider.take_damage(DAMAGE)
		die()

func setup(poz, rot):
	position = poz
	rotation = rot

func die():
	queue_free()


func _on_Timer_timeout():
	die()
