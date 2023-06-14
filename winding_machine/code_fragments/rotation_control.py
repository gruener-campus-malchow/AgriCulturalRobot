#!/usr/bin/env python3
import RPi.GPIO as GPIO
import time

servoPIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN, GPIO.OUT)
servo = GPIO.PWM(servoPIN, 50) # GPIO 18 als PWM mit 50Hz
dutyCycle = 7.2
steps = 0.05
servo.start(0) # Initialisierung

forward_min = 6.5
forward_max = 4

backwards_min = 7.5
backwards_max = 9

while True:
    zahl = float(input("direction and speed from -1.0 to 1.0 "))
    
    if zahl < 0:
        difference = backwards_max - backwards_min
        dc_change = difference * zahl
        new_dc = backwards_min + dc_change
    if zahl > 0:
        difference = forward_min - forward_max
        dc_change = difference * zahl
        new_dc = forward_min - dc_change
    else:
        new_dc = 0

    servo.ChangeDutyCycle(new_dc)
    print("new direction and speed: " + str(new_dc))
