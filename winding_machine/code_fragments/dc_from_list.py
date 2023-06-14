# Bilbiotheken, die man benötigt
# import RPi.GPIO as GPIO

# GPIO-Pin, an dem der Servo angeschlossen ist
#servoPIN = ***
# Frequenz des PWM-Signals
#frequenz = ***

# ein paar Einstellungen
#GPIO.setmode(GPIO.BCM)
#GPIO.setup(servoPIN, GPIO.OUT)

# bereite das Signal am jeweiligen  Pin mit der eingestellten Frequenz vor
#pwmSignal = GPIO.PWM(servoPIN, frequenz)
# starte das Signal mit einer Weite von 0
#pwmSignal.start(0)

position =[4.0, 5.2, 6.4, 7.1, 8.7, 9.3, 10.12, 11.5, 12.1]

print(position[5])
print(position[6])

try:
  while True:
    weite = int(input('Gib eine Position ein zwischen 0 und 9: '))
    print('Ich fahre folgende Positionan '+str(weite))
    tastgrad=position[weite]
    print('der Tastgrad dazu ist: '+str(tastgrad))
#pwmSignal.ChangeDutyCycle(weite)

except KeyboardInterrupt:
  #pwmSignal.stop()
  #GPIO.cleanup()
    pass
