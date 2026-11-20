from pathlib import Path
from PIL import Image, ImageDraw, ImageFont
p=Path(__file__).resolve().parent.parent
def font(size,bold=False):
    return ImageFont.truetype('arialbd.ttf' if bold else 'arial.ttf',size)
def label(x,y,s,n=24,c='#14392e',bold=False):
    d.text((x,y),s,fill=c,font=font(n,bold))
im=Image.new('RGB',(1120,640),'#f3f8f1'); d=ImageDraw.Draw(im)
label(65,40,'Curva de tensión',42,bold=True)
label(65,103,'Último turno · El invernadero',23)
for i in range(1,6):
    y=530-(i-1)*85
    d.line((117,y,1050,y),fill='#c9dbcd',width=2)
    label(76,y-14,str(i))
pts=[(143+i*175,530-(v-1)*85) for i,v in enumerate([2,2,4,3,5,1])]
d.line(pts,fill='#247055',width=6)
for i,(x,y) in enumerate(pts,1):
    d.ellipse((x-9,y-9,x+9,y+9),fill='#247055',outline='white',width=3)
    label(x-18,557,f'B{i}',22)
im.save(p/'curva_tension.png')
im=Image.new('RGB',(1500,1540),'#f3f8f1'); d=ImageDraw.Draw(im)
label(48,34,'Último turno',49,bold=True)
label(50,100,'El invernadero · Storyboard de gameplay · Vista cenital',25)
panels=[
 ('V01 / B1 / ESC-01','El apagón','Ciclo de riego interrumpido','Banco','Lina entra; aviso y zumbido.','Avanza al acercarse al banco.'),
 ('V02 / B2 / ESC-01','Prueba la batería','Batería lista','Banco + batería','Lina inserta y retira con E; pitido de confirmación.','Avanza al llevar la batería al corredor.'),
 ('V03 / B3 / Corredor','El desvío','Paso inundado','Pasarela','Lina sigue las flechas; ambiente de goteo.','Avanza al llegar a la antesala.'),
 ('V04 / B4 / Antesala','Consulta el plano','Gota = Riego  /  Hélice = Ventilación','Plano','Lina lee el plano; ambiente tenue.','Avanza al entrar al control con la batería probada.'),
 ('V05 / B5 / ESC-02','Elige la toma','Riego / Ventilación','Toma de riego','Lina pulsa E; ventilación rechaza con texto y aviso.','Acierto → V06. Error → reintenta o vuelve a V04.'),
 ('V06 / B6 / ESC-02','El agua vuelve','Riego restablecido','Salida','Aspersores activos y sonido de agua.','Al cruzar la salida termina el nivel.')
]
for i,(code,title,msg,obj,note,step) in enumerate(panels):
    x=48+714*(i%2); y=155+451*(i//2)
    d.rounded_rectangle((x,y,x+688,y+422),radius=18,fill='white',outline='#c0d1c5',width=2)
    label(x+24,y+16,code,20); label(x+24,y+44,title,30,bold=True)
    a,b=x+24,y+94
    d.rounded_rectangle((a,b,a+640,b+224),radius=12,fill='#e3eee3')
    label(a+16,b+13,msg,22,bold=True)
    cx,cy=a+106,b+141
    d.ellipse((cx-26,cy-26,cx+26,cy+26),fill='#24563f')
    label(cx-23,cy+32,'Lina',19)
    if i in (1,2,3,4):
        d.rounded_rectangle((cx+23,cy-29,cx+45,cy-5),radius=4,fill='#d0913f')
    tx=a+430
    d.line((cx+68,cy,tx-19,cy),fill='#397759',width=5)
    d.polygon([(tx-18,cy),(tx-31,cy-8),(tx-31,cy+8)],fill='#397759')
    d.rounded_rectangle((tx,cy-31,tx+183,cy+31),radius=10,fill='#bdd7c3')
    label(tx+12,cy-12,obj,20,bold=True)
    if i==2:
        d.rectangle((a+228,b+52,a+437,b+92),fill='#a4cadd')
        label(a+243,b+60,'Barrera e inundación',17)
    if i==4:
        label(a+422,b+63,'Toma de ventilación',18)
    if i==5:
        for j in range(3):
            k=a+230+j*49
            d.arc((k,b+62,k+46,b+105),180,360,fill='#367895',width=3)
    label(x+24,y+337,note,21)
    label(x+24,y+370,step,21,bold=True)
im.save(p/'04_storyboard.png')
