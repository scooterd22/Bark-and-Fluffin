extends Area2D

var sheep_in_pen = []
const max_sheep = 3



func _on_body_entered(body: Node2D) -> void:
	print("test?")
	print(body)
	if body.is_in_group("Sheep"):
		sheep_in_pen.append(body)
		print("Sheep entered:", body.name)
		check_sheep()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Sheep"):
		sheep_in_pen.erase(body)
		check_sheep()
		
		
		


func check_sheep():
	if sheep_in_pen.size() == max_sheep:
		print("All sheep are in the pen! You win!")
