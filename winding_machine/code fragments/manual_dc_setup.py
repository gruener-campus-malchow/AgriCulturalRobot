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

while True:
    zahl = float(input("Bitte neuen Tastgrad eingeben: "))
    print("Der neue Tastgrad ist" + str(zahl))
    servo.ChangeDutyCycle(zahl)

