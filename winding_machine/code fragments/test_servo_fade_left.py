# -*- coding: utf-8 -*- 

import RPi.GPIO as GPIO
import time

servoPIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN, GPIO.OUT)

servo = GPIO.PWM(servoPIN, 50) # GPIO 18 als PWM mit 50Hz
servo.start(0) # Initialisierung

dutyCycle = 7.2
steps = 0.05

try:
  while dutyCycle<9:
    dutyCycle = dutyCycle+steps
    print("Aktueller dutyCycle: "+str(dutyCycle))
    servo.ChangeDutyCycle(dutyCycle)
    time.sleep(0.01)
  print("rotiere weiter für 5 Sekunden")
  time.sleep(5)
except KeyboardInterrupt:
  p.stop()
  GPIO.cleanup()
