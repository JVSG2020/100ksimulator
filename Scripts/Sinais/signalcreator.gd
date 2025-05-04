extends Node

signal cam_tela
signal cam_info
signal cam_arq

func ignore (): 
	if false:
		cam_arq.emit()
		cam_info.emit()
		cam_tela.emit()
		
