extends Area2D

export (int) var DAMAGE

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
func setup(poz):
	position = poz
	

func _on_Timer_timeout():
	queue_free()


func _on_melee_body_entered(body):
	if body.has_method("take_damege"):
		body.take_damage(DAMAGE)
