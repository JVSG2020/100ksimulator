extends Node

signal cam_tela
signal cam_info
signal cam_arq
signal loadreg
signal exec

func ignore (): 
	if false:
		cam_arq.emit()
		cam_info.emit()
		cam_tela.emit()
		loadreg.emit()
		exec.emit()
