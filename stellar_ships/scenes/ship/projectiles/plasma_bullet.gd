extends KinematicBody2D
var velocity = Vector2.ZERO
var speed = 600
var sound_done = false
var kill_on_sound = false
var explosion = preload("res://scenes/explosions/small-explosion.tscn").instance()
func _physics_process(delta):
	velocity = Vector2.ZERO
	velocity += transform.x * speed
	velocity = move_and_slide(velocity)


func _on_kill_time_timeout():
	spawn_explosion()
	queue_free()



func spawn_explosion():
	explosion.position = get_global_position()
	get_tree().get_root().add_child(explosion)

func _on_hit_box_body_entered(body):
	if sound_done:
		spawn_explosion()
		queue_free()
	else:
		spawn_explosion()
		hide()
		kill_on_sound = true


func _on_AudioStreamPlayer2D_finished():
	sound_done = true
	if kill_on_sound:
		queue_free()

