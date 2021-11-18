extends KinematicBody2D
var max_speed = 200
var speed_gain = 5
var speed_loss = 3
var speed = 0
var rotation_speed = 2

var can_shoot = true
var gun_cool_down = 0.5

onready var plasma_bullet = preload("res://scenes/ship/projectiles/plasma_bullet.tscn")

var velocity = Vector2.ZERO
var rotation_dir = 0

var engine = false

var energy = 100
var max_energy = 100
var energy_gain = 1

var plasma_bullet_energy = 15

func get_input():
	if Input.is_action_pressed("shoot"):
		shoot()
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed('right'):
		rotation_dir += 1
	if Input.is_action_pressed('left'):
		rotation_dir -= 1
	if Input.is_action_pressed('up'):
		speed += speed_gain
		engine = true
	else:
		speed -= speed_loss
		engine = false
	set_speed()
	if speed != 0:
		velocity += transform.x * speed


func set_speed():
	if speed > max_speed:
		speed = max_speed
	if speed < 0:
		speed = 0


func engine():
	if engine == true:
		$engine.emitting = true
	else:
		$engine.emitting = false


func _physics_process(delta):
	engine()
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)


func shoot():
	if can_shoot && energy >= plasma_bullet_energy:
		energy -= plasma_bullet_energy
		can_shoot = false
		$shoot_cool_down.wait_time = gun_cool_down
		$shoot_cool_down.start()
		var b = plasma_bullet.instance()
		b.position = $"bullet spawn".get_global_position()
		b.rotation = get_rotation()
		get_tree().get_root().add_child(b)


func _on_shoot_cool_down_timeout():
	can_shoot = true


func _on_regain_energy_timeout():
	energy += energy_gain
	if energy > max_energy:
		energy = max_energy
