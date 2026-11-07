extends Node
class_name AudioManager

## AUDIO LINKS
const CRASCH_EPA = preload("uid://ni1y1w432d8y")
const ENERGIDRYCK = preload("uid://dpr6fw7koy44y")
const HOVER_PÅ_UPGRADERING__KORT_ = preload("uid://wa1fhw03irq6")
const MOTORLJUD_1_EPA = preload("uid://81h62fvowxqo")
const STANNA_EPA = preload("uid://bk16bgx0son5r")
const START_EPA = preload("uid://dnqka6x5bl1oh")
const UPGRADERINGSLJUD = preload("uid://dldq4pa6txajm")
const VIND_EPA = preload("uid://dgcvrtathsxym")


func _ready() -> void:
	play_sfx(START_EPA)

func play_sfx(_stream) -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = _stream
	player.autoplay = true
	player.play()
	player.finished.connect.bind(sfx_finished)

func sfx_finished(streamPlayer):
	streamPlayer.queue_free()
