#!/usr/bin/env python3
import RPi.GPIO as GPIO
import time

GPIO.cleanup()

servoPIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN, GPIO.OUT)
servo = GPIO.PWM(servoPIN, 50) # GPIO 18 als PWM mit 50Hz
dutyCycle = 7.2
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
		while dutyCycle<9:

			dutyCycle = dutyCycle + steps
			print("Aktueller dutyCycle: "+str(dutyCycle))
			servo.ChangeDutyCycle(dutyCycle)
			time.sleep(0.01)
	except KeyboardInterrupt:
		servo.stop()
		GPIO.cleanup()
  		
def stop_servo():
	global steps
	global dutyCycle
	global servo
	
	try:
		while dutyCycle>7.2:
			dutyCycle = dutyCycle-steps
			print("Aktueller dutyCycle: "+str(dutyCycle))
			servo.ChangeDutyCycle(dutyCycle)
			time.sleep(0.01)
	except KeyboardInterrupt:
		servo.stop()
		GPIO.cleanup()


def loop():
	while True:
		if (0 == GPIO.input(ObstaclePin)):
			print ("Detected Barrier!")
			start_servo();
		else:
			stop_servo();


def destroy():
	GPIO.cleanup()                     # Release resource

if __name__ == '__main__':     # Program start from here
	setup()
	try:
		loop()
	except KeyboardInterrupt:  # When 'Ctrl+C' is pressed, the child program destroy() will be  executed.
		destroy()
        

