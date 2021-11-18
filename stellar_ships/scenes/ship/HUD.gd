extends CanvasLayer

onready var p = get_parent()
func _process(delta):
	$energy.max_value = p.max_energy
	$energy.value = p.energy
