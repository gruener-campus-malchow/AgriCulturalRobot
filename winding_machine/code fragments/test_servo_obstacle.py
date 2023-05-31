#!/usr/bin/env python3
import RPi.GPIO as GPIO
import time


servoPIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(servoPIN, GPIO.OUT)
servo = GPIO.PWM(servoPIN, 50) # GPIO 18 als PWM mit 50Hz
dutyCycle = 7.2
steps = 0.05

ObstaclePin = 27

def setup():
	GPIO.setup(ObstaclePin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def start_servo():
	servo.start(0) # Initialisierung

	try:
		while dutyCycle<9:
			global dutyCycle = global dutyCycle + global steps
			print("Aktueller dutyCycle: "+str(global dutyCycle))
			servo.ChangeDutyCycle(global dutyCycle)
			time.sleep(0.01)
	except KeyboardInterrupt:
		servo.stop()
		GPIO.cleanup()
  		
def stop_servo():
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
        

