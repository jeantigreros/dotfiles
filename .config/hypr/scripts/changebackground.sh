#!/bin/bash

# Directorio que contiene tus imágenes de fondo
wallpapers_dir=~/Pictures/wallpapers/

# Seleccionar una imagen al azar del directorio
random_image=$(ls $wallpapers_dir | shuf -n 1)

# Ruta completa de la imagen seleccionada
image_path="$wallpapers_dir/$random_image"

# Establecer el fondo de pantalla
hyprctl hyprpaper wallpaper "eDP-1, $image_path"
