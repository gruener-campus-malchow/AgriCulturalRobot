#!/usr/bin/env python3
import RPi.GPIO as GPIO
import time

GPIO.cleanup()

servoPIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN, GPIO.OUT)
servo = GPIO.PWM(servoPIN, 50) # GPIO 18 als PWM mit 50Hz
minimal_dc = 6.7 
dutyCycle = minimal_dc

steps = 0.05
servo.start(0) # Initialisierung

ObstaclePin = 27

def setup():
	GPIO.setup(ObstaclePin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def start_servo():
	global steps
	global dutyCycle
	global servo

	try:
		while dutyCycle < 9:
			dutyCycle = dutyCycle + steps
			print("Aktueller dutyCycle: " + str(dutyCycle))
			servo.ChangeDutyCycle(dutyCycle)
			time.sleep(0.01)

	except KeyboardInterrupt:
		servo.stop()
		GPIO.cleanup()
  		
def stop_servo():
	global steps
	global dutyCycle
	global servo
	global minimal_dc
	
	try:
		while dutyCycle > minimal_dc:
			dutyCycle = dutyCycle - steps
			print("Aktueller dutyCycle: " + str(dutyCycle))
			servo.ChangeDutyCycle(dutyCycle)
			time.sleep(0.01)
		servo.ChangeDutyCycle(0)

	except KeyboardInterrupt:
		servo.stop()
		GPIO.cleanup()


def loop():

	start_servo()
	counter = 0
	max_count = 10
	event = 0
	while counter < max_count:
		if (0 == GPIO.input(ObstaclePin)):
			if event == 0:
				event = 1
				counter = counter + 1
		else:
			event = 0
	stop_servo()


def destroy():
	GPIO.cleanup()                     # Release resource

if __name__ == '__main__':     # Program start from here
	setup()
	try:
		loop()
	except KeyboardInterrupt:  # When 'Ctrl+C' is pressed, the child program destroy() will be  executed.
		destroy()
        

