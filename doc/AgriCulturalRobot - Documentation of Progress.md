# AgriCulturalRobot - Documentation of Progress

[toc]

## Skelett

### Prototyp A



#### Prototyp A V.0.1 aus Lego
- Hinzufügen von Fahradschläuchen als Federung (Zugfederung statt Druckfederung[häufiger zu finden])
- Stabeliesierung des Torsos <-- Kraft auf die Beine hatte biegungen im Körper verursacht

![](https://i.imgur.com/olyadOA.jpg)
![](https://i.imgur.com/2SjwSNY.jpg)
[![](https://i.imgur.com/HP4S4TG.mp4)](https://i.imgur.com/HP4S4TG.mp4)


#### Prototyp A V.0 aus Lego
- Ein Beinpaar
    - +hinzufügen eines weiteren 
- Gemeinsammes Anheben der Beine 
- hinzufügung eines Drehgelenks 
- hinsufügen eines weiteren Beinparres
- Druckfedern
 
![Seitenansicht](https://i.imgur.com/44uEmBC.jpg)

![Ansicht auf ein Drehgelenk](https://i.imgur.com/JeHZUxQ.jpg)

![Gesamt ansicht](https://i.imgur.com/Z4WCvIp.jpg)


### Prototyp B


#### Prototyp B V.0 aus Lego mit Asymetrischesrad oder Stöckern

Vorteile:

- Besserer grip in Ungewöhnlichen Terrain
- Weniger Boden verdichtung 
- Weniger partikel aufwirbelung 
- weniger mechanik
    - Weniger Verschleiß
    - Weniger Points of failure

Nachteile:

- Live positionirung des Ei's
- Abstand zwischen den Eierrädern kann zu groß sein
    - Körper hat Boden- /Hindernisskontakt aber Räder nicht
- mögliche Aufstehhilfe nötig für hohe hindernisse


## Mitnehmer/ Getriebe 

### Mitnehmer
 - Elektromagnetische Koppelung von Rotor und Mitnehmer 
 - Elektromagneten bauen langsam ihr Magnetfeld auf damit es nicht so ruckartig ist
 - Weniger Motoren nötig




## Muskeln (MuscleMotor)

### Ziele

Entwicklung eines Muskels, der möglichst nur mit Teilen auskommt, die leicht verfügbar sind.

Zunächst wird ein Prototyp gebaut, der ohne Kugellager auskommt und sonst nur Teile aus dem 3D-Drucker (die man auch anders fertigen kann), Schrauben, Permanentmagnete und Kupferdraht aus recycelten Spulen besteht.

### 3D-Modell

Das Modell wurde mit der CAD-Technologie [OpenSCAD](https://openscad.org) entwickelt. Das ist eine Sprache, RenderEngine und IDE, bei welcher 3D-Modelle programmiert werden. Es kann STL-Dateien exportieren. STL ist ein Industrie-Standard, der von Slicern verstanden wird.

Das erlaubt relativ schnelles Prototyping mit einfachen geometrischen Grundformen. Gute Designs sind in OpenSCAD sogar parametrisierbar. Beipsielsweise könnte man die Anzahl der Phasen und bestimmte Dimmensionen flexibel im Design halten.

![](https://i.imgur.com/0biIWmp.png)

Der Rotor in der Mitte enthält die Permanentmagnete und nimmt die Fäden auf, welche durch den Rotor verdrillt werden.

![](https://i.imgur.com/Kr99AL1.png)


### Code

Der folgende Code realisiert das 3D-Modell. Zu Beginn stehen einige Parameter, die später allerdings im Design nicht weiter verwendet werden. Hier gibt es zum jetzigen Zeitpunkt Entwicklungspotential.

~~~openScad
$fn = 30;
phasen = 2;
faktor = 2;
anzahl = phasen * faktor;

halterung();
antriebsspulen();
kern();
//spulenaufnahmen();
alle_spulenaufnahmen();
//spulenkerne();
//spulenkern();

module kern(){
    difference(){
        cylinder(h=10,r=18, center= true);
        {
            magnetloecher();
            schnurloecher();
        }
    }
}

module magnetloecher(){
    schrittweite = 360 / anzahl;
    for (i = [0:anzahl]) {
        rotate([0,0,i*schrittweite])translate([8,0,0])rotate([0,90,0])cylinder(h=20, r=2.5, center = true);
    }
}

module schnurloecher(){
    distanz=8;
    
    translate([distanz,distanz,0])cylinder(h=20,r=1, center= true);
    translate([-distanz,-distanz,0])cylinder(h=20,r=1, center= true);
    translate([distanz,-distanz,0])cylinder(h=20,r=1, center= true);
    translate([-distanz,distanz,0])cylinder(h=20,r=1, center= true);
}


module spulenkerne(){
    rotate([0,45,0])translate([18,0,0])rotate([0,90,0])spulenkern();
    rotate([0,-45,0])translate([18,0,0])rotate([0,90,0])spulenkern();
    rotate([0,0,0])translate([18,0,0])rotate([0,90,0])spulenkern();
}

module spulenaufnahmen(){
    
    rotate([0,45,0])translate([26,0,0])spulenaufnahme();
    rotate([0,-45,0])translate([26,0,0])spulenaufnahme();
    translate([26,0,0])spulenaufnahme();
    
}

module spulenkern(){
    difference(){
        union(){
            cylinder(h=10,r=3, center= true);
            translate([0,0,-5])cylinder(h=1,r=5, center= true);
            translate([0,0,5])cylinder(h=1,r=5, center= true);
        }
        union(){
            cylinder(h=12,r=2, center= true);
            translate([4,0,0])cube([2,1,12], true);
        }
    }  
}

module antriebsspulen(){
    schrittweite = 360 / anzahl;
    for (i = [0:anzahl]) {
        rotate([0,0,i*schrittweite])translate([8,0,0])spulenkerne();
    }
}

module halterung(){
    distance = 73;
    difference(){
        rotate([0,0,45])cube([65,65,10],true);
        union()
        {
            cylinder(h=15,r=25,center=true);
            
            cube([distance,11,11],true);
            rotate([0,0,90])cube([distance,11,11],true);
            translate([-5,5,0]) rotate([0,90,45])cylinder(h=80,r=2.5,center=true);
            translate([5,-5,0]) rotate([0,90,45])cylinder(h=80,r=2.5,center=true);

            translate([-5,-5,0]) rotate([0,90,-45])cylinder(h=80,r=2.5,center=true);
            translate([5,5,0]) rotate([0,90,-45])cylinder(h=80,r=2.5,center=true);
            rotate([0,90,0])cylinder(h=100,r=2.5,center=true);
            rotate([0,90,90])cylinder(h=100,r=2.5,center=true);
    
            translate([0,52,0])cube([20,20,20],true);
            translate([0,-52,0])cube([20,20,20],true);
            translate([52,0,0])cube([20,20,20],true);
            translate([-52,0,0])cube([20,20,20],true);            
        }       
    }
}

module spulenaufnahme(){
    difference()
    {
        cube([5,10,23],true);
        rotate([0,90,0])cylinder(h=6,r=2.5,center=true);
    }
}

module alle_spulenaufnahmen(){
    schrittweite = 360 / anzahl;
    for (i = [0:anzahl]) {
        rotate([0,0,i*schrittweite])translate([8,0,0])spulenaufnahmen();
    }
}
~~~

### Prototypen

#### musclemotor.v.0

Wir haben einen Ausdruck mittlerer Qualität mit einem einfachen 3D-Drucker hergestellt.

![](https://i.imgur.com/6laUZEw.png)

Anschließend montierten die Einzelteile und entwarfen ein Gestell, in welchem der Motor im Sinne eines *Proof Of Concept* zeigen kann, dass er grundsätzlich funktioniert.

![](https://i.imgur.com/F0RP8yF.png)

Dabei benutzten wir Teile eines sogenannten "Stabilbaukasten". Bis heute wird dieses Spielzeug produziert.

##### Designschwächen

Bei der Montage sind uns schon einige Designschwächen aufgefallen, die wir im folgenden Auflisten:

- Negativ-Mutter (Mutter-Nut) im Rahmen
- Rahmen teilbar, durch Stabilbaukasten
- Abstand der Bohrungen kompatibel zu Stabilbaukasten stellen

Die Schlussfolgerung ist, dass wir einen neuen Prototypen entwickeln werden. Parallel dazu wird eine Wickelmaschine aus Lego- und Stabilbaukastenteilen erstellt. 

#### musclemotor.v.0.1

![Slicing der überarbeiteten Teile](https://i.imgur.com/ioIQbzS.png)

Nach dem Druck:

![](https://i.imgur.com/3CNe5sL.jpg)


##### Designschwächen v0.1

- Mutter-Nut an der Mittelspule-Halterung ist überflüssig
- Mutter-Nut muss an Ecken des Frames
- Mutter (positiv) als Kante an Spule
- Rotor verkleinern (90%)

### Wickelmaschine

Diese soll durch einen Raspberry-Pi so gesteuert werden, dass wir die Windungszahl der Elektromagneten bestimmen können. 

Hier ein Bild der Bauphase:

![](https://i.imgur.com/BTTm1IQ.png)

## Wishlist

### Lego

- mehr Lego-Technik
- modernes Lego-Technik
- Schneckenwellen
- Ordnungssystem für Lego-Technik

## Experimente

### Magnetisierung in Spule

Können wir mit einer (selbst gebauten) Spule und einem Signalgenerator eine normale Eisenschraube stark erhitzen und anschließend nennenswert dauerhaft magnetisieren?
