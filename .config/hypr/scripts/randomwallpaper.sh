#!/bin/bash



DIR=$HOME/Pictures/wallpapers/ 

PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}


swww query || swww init


swww img ${DIR}/${RANDOMPICS} --transition-fps 60 --transition-type any --transition-duration 3 
