extends Area2D

var can_interact = false
#const DIALOG = preload("res://Home/dialog.tscn")
#var dialog
var notification = true

func _physics_process(_delta):
	$Sprite.play()
	

func _on_computer_body_entered(body):

	if body.name == "Moonman2D" and notification:
		$compnotification.visible = true
		$Label.visible = true
		can_interact = true
		
	#auto deletes object
	#queue_free() 
	
func _on_computer_body_exited(body):
	if body.name == "Moonman2D":
		can_interact = false
		$Label.visible = false
		#if dialog:
			#dialog.queue_free()
			#dialog = null

func _input(_event):
	if Input.is_key_pressed(KEY_SPACE) and can_interact == true and notification: 
		notification = false
		$compnotification.visible  = false
		$Label.visible = false
		#dialog = DIALOG.instance()
		#get_parent().add_child(dialog)
		$Sprite.play("off")
