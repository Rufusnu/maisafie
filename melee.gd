extends Area2D

export (int) var DAMAGE

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var knock = 400

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func setup(dist, facing_right):
	#user facing_right to determine if you need to flip the animation
	if !facing_right:
		knock = -knock
	position.x += dist
	$Sprite.flip_h=!facing_right
	

func _on_Timer_timeout():
	queue_free()


func _on_melee_body_entered(body):
	#print("Zing")
	if body.name != "Player" and body.has_method("take_damage"):
		body.take_damage(DAMAGE)
		if body.has_method("knock"):
			var mov = Vector2(knock, -abs(knock)/2)
			body.knock(mov)
