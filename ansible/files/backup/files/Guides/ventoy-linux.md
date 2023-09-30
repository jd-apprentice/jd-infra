---
title: "Como armar un USB booteable desde linux"
date: "2023-06-19T22:37:25.509Z"
slug: "como-armar-un-usb-booteable-desde-linux"
image: "https://www.ventoy.net/static/img/screen/screen_uefi_en.png?v=4"
---

## Descargar Ventoy

- Nos dirigimos a la pagina de Ventoy [Link](https://www.ventoy.net/en/download.html)
- Descargamos el archivo llamado `ventoy-1.0.79-linux.tar.gz`

## Descargar ISO's a utilizar

- Antes de empezar el proceso seria ideal que ya tengan sus ISO's preparadas en mi caso voy a utilizar
una de Ubuntu y otra de Windowsles dejo en enlace a ambas en caso que las necesiten
- [Ubuntu](https://ubuntu.com/desktop)
- [Windows10](https://www.microsoft.com/en-us/software-download/windows10ISO)

## Descomprimir Ventoy y pararnos en su carpeta

- Ahora con el archivo `ventoy-1.0.79-linux.tar.gz` nos dirigimos hacia nuestra carpeta de descargas `cd Downloads/`
- Seguido de eso vamos a descomprimir el archivo con el siguiente comando `tar -xf ventoy-1.0.79-linux.tar.gz` o simplemente
haciendo click derecho y extraer aqui
- Despues vamos a movernos dentro de la carpeta que nos genero con `cd ventoy-1.0.79/`

## Hacer el USB booteable

- Encontrandonos dentro de la carpeta de ventoy podemos hacer un `ls -ltr` para asegurarnos que estemos bien posicionamos,
si vemos el archivado llamado `Ventoy2Disk.sh` significa que estamos en el lugar correcto.
- Aqui tendriamos que poner nuestro comando ya que en mi caso es `sudo sh Ventoy2Disk.sh -I -s /dev/sdc` para esta ultima parte
hace falta que sepan cual es su usb y lo pueden saber de esta forma
- Hacemos un `sudo fdisk -l` y recibiremos una lista de nuestros discos el cual puede el ultimo generalmente es nuestro USB 
y ahi mismo tiene el nombre de su particion ->
- ![image](https://user-images.githubusercontent.com/68082746/184545474-125dfd32-3026-410b-866a-305ad13924ce.png)
Como pueden ver el mio ahi en la columna de device dice su nombre, para cuando vayamos a utilizar nuestro comando de booteable
no hace falta poner los numeros ya que esos representan una particion.

## Finalizado

- Una vez que corrimos nuestro comando para hacer el USB booteable deberiamos tener un mensaje como este ->
![image](https://user-images.githubusercontent.com/68082746/184545525-837654e4-aa3d-482d-8ab6-944280cd68c7.png)
- Si ven esto es por que salio todo bien y ya pueden poner sus ISO's dentro del USB