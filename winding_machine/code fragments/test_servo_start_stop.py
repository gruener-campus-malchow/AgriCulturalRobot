# -*- coding: utf-8 -*- 

import RPi.GPIO as GPIO
import time

servoPIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN, GPIO.OUT)

servo = GPIO.PWM(servoPIN, 50) # GPIO 18 als PWM mit 50Hz
servo.start(0) # Initialisierung

global dutyCycle
dutyCycle = 7.2

global steps
steps = 0.05

def increase():
  global dutyCycle
  while dutyCycle < 9:
    dutyCycle = dutyCycle+steps
    print("Aktueller dutyCycle: "+str(dutyCycle))
    servo.ChangeDutyCycle(dutyCycle)
    time.sleep(0.05)

def decrease():
  global dutyCycle
  while dutyCycle > 7.2:
    dutyCycle = dutyCycle-steps
    print("Aktueller dutyCycle: "+str(dutyCycle))
    servo.ChangeDutyCycle(dutyCycle)
    time.sleep(0.01)

try:
  while True:
    increase()
    print("rotiere weiter für 5 Sekunden")
    time.sleep(5)
    decrease()
    print("warte für 5 Sekunden")
    time.sleep(5)

except KeyboardInterrupt:
  servo.stop()
  GPIO.cleanup()

