extends Area

onready var _e1 = connect("body_entered", self, "_on_body_entered")
onready var _e2 = connect("body_exited", self, "_on_body_exited")

func _on_body_entered(body: Node):
	if body.name == "Spaceman":
		body.add_gravity(self)

func _on_body_exited(body: Node):
	if body.name == "Spaceman":
		body.remove_gravity(self)
