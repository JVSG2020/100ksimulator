extends Node

signal cam_tela
signal cam_info
signal cam_arq

# Fazendo a IDE calar a boca com um sinal falso
func _ignore_warning():
	if false:
		cam_tela.emit()
		cam_info.emit()
		cam_arq.emit()
