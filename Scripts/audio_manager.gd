extends Node
class_name AudioManager

## AUDIO LINKS
const BLINKANDE_LAMPA = preload("uid://ce5uw7qwj5x03")
const BOOOST = preload("uid://csuqrl21syws2")
const CRASCH_EPA = preload("uid://ni1y1w432d8y")
const ENERGIDRYCK = preload("uid://dpr6fw7koy44y")
const EPA_I_LERA = preload("uid://c2ummxx7qclep")
const HJUL_PÅ_ASFALT = preload("uid://n7rrbawfxit3")
const HJUL_PÅ_GRÄS = preload("uid://fhv3lfj4j2k3")
const HOVER_PÅ_UPGRADERING__KORT_ = preload("uid://wa1fhw03irq6")
const JETMOTOR_STARTAR = preload("uid://dkl62byevm2rb")
const LOOPAD_JETMOTOR = preload("uid://c1bq7k23ph3ji")
const LOOPANDE_FLÄKT_2 = preload("uid://bsq8c8ykukrle")
const LOOPANDE_FLÄKTLJUD = preload("uid://dbv1yq5ybtj3i")
const MOTORLJUD__1__EPA = preload("uid://81h62fvowxqo")
const POPPY_BOTTLE = preload("uid://b1x4d3dh2f2f7")
const STACKING_SNUS = preload("uid://sxwds0fx1tsd")
const STANNA_EPA = preload("uid://bk16bgx0son5r")
const START_EPA = preload("uid://dnqka6x5bl1oh")
const STARTLJUD_FLÄKT = preload("uid://de5ajn6ix67d0")
const UPGRADERINGSLJUD = preload("uid://dldq4pa6txajm")
const V_IND_EPA = preload("uid://dgcvrtathsxym")
const ÄLG_ANTHON_CRY = preload("uid://crqg0ap47gyiw")
const ÄLGEN_ANTHON_KRASCH = preload("uid://chnb7rpcbt7i2")
const ÄLGEN_ISABELLE_CRY = preload("uid://x20vn2ocqi2r")
const ÄLGEN_ISABELLE_KRASCH = preload("uid://d265wfupvj40y")
const ÖPPNA_SNUS = preload("uid://c63g7xxlbfbta")

func _ready() -> void:
	play_sfx(START_EPA)

func play_sfx(_stream) -> void:
	var player = AudioStreamPlayer.new()
	add_child(player)
	player.stream = _stream
	player.autoplay = true
	player.play()
	player.finished.connect(sfx_finished.bind(player))

func sfx_finished(streamPlayer):
	streamPlayer.queue_free()
