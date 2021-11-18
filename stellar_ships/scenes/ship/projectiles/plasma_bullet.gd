extends KinematicBody2D
var velocity = Vector2.ZERO
var speed = 600

func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity += transform.x * speed
	velocity = move_and_slide(velocity)
