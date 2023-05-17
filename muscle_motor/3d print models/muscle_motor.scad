//include <ISOThread.scad>;

$fn = 30;
phasen = 2;
faktor = 2;
anzahl = phasen * faktor;
toleranz_nut = 0.1;

// ####### COMPLETE MODEL
//complete();

// ####### PRINTING

//spulenaufnahmen();
//halterung();
kern();

// ####### TESTING
//spulenaufnahmen();
//spulenkerne();
//spulenkern();
//halterung();
//m4nut();

module complete(){
    halterung();
    antriebsspulen();
    kern();
    alle_spulenaufnahmen();
}

module kern(){
    difference(){
        cylinder(h=10,r=25/2, center= true);
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
    distanz=7.5;
    
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
    
    rotate([0,-45,0])difference(){
        translate([26,0,0])spulenaufnahme();
        translate([26,0,0])rotate([0,90,0])m4nut();
    }
    rotate([0,0,0])difference(){
        translate([26,0,0])spulenaufnahme();
        translate([26,0,0])rotate([0,90,0])m4nut();
    }
    rotate([0,45,0])difference(){
        translate([26,0,0])spulenaufnahme();
        translate([26,0,0])rotate([0,90,0])m4nut();
    }
    
}

module spulenkern(){
    difference(){
        union(){
            cylinder(h=10,r=3, center= true);
            //translate([0,0,-5])cylinder(h=1,r=5, center= true);
            //translate([0,0,5])cylinder(h=1,r=5, center= true);
            translate([0,0,4.5])rotate([0,0,180/6])nut(6,1,0);
            translate([0,0,-5.5])rotate([0,0,180/6])nut(6,1,0);
        }
        union(){
            cylinder(h=12,r=2.5, center= true);
            translate([4.3,0,0])cube([2.5,1,12], true);
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
    
    
    difference()
    {
        rotate([0,0,45])cube([65,65,10],true);
        union()
        {
            //center hole
            cylinder(h=15,r=25,center=true);
            
            //divider
            rotate([0,0,45])cube([0.5,100,20],true);
            
            //cutoff edges for spulenhalter
            cube([distance,11,11],true);
            rotate([0,0,90])cube([distance,11,11],true);
            //holes edges
            rotate([0,90,0])cylinder(h=100,r=2.5,center=true);
            rotate([0,90,90])cylinder(h=100,r=2.5,center=true);
            
            translate([0,52,0])cube([20,20,20],true);
            translate([0,-52,0])cube([20,20,20],true);
            translate([52,0,0])cube([20,20,20],true);
            translate([-52,0,0])cube([20,20,20],true);            
            
            //holes for stabilbaukasten
            rotate([0,0,45])union(){
                translate([0,5,0]) rotate([0,90,0])  cylinder(h=80,r=2.5,center=true);
                translate([22,5,0]) rotate([0,90,0])  m4nut();
                translate([-26,5,0]) rotate([0,90,0])  m4nut();
                
                translate([0,-5,0]) rotate([0,90,0])cylinder(h=80,r=2.5,center=true);
                translate([22,-5,0]) rotate([0,90,0])  m4nut();
                translate([-26,-5,0]) rotate([0,90,0])  m4nut();

                translate([-5,0,0]) rotate([0,90,90])cylinder(h=80,r=2.5,center=true);
                translate([-5,22,0]) rotate([0,90,90])  m4nut();
                translate([-5,-26,0]) rotate([0,90,90])  m4nut();
                
                translate([5,0,0]) rotate([0,90,90])cylinder(h=80,r=2.5,center=true);
                translate([5,22,0]) rotate([0,90,90])  m4nut();
                translate([5,-26,0]) rotate([0,90,90])  m4nut();
            }
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

module m4nut(){
    //WrenchSizes=1;
    //translate([0,0,2])hex_nut(4);
    scale([1+toleranz_nut,1+toleranz_nut,1])union()    {
        color("blue") translate([-2,-3.5,0])cube([4,7,4]);
        color("blue") rotate([0,0,180/3])translate([-2,-3.5,0])cube([4,7,4]);
        color("blue") rotate([0,0,-180/3])translate([-2,-3.5,0])cube([4,7,4]);
    }
}

module nut(size, height, toleranz){
    factor = size/4;
    scale([factor+toleranz,factor+toleranz,1])union(){
        color("red") translate([-2,-3.5,0])cube([4,7,height]);
        color("red") rotate([0,0,180/3])translate([-2,-3.5,0])cube([4,7,height]);
        color("red") rotate([0,0,-180/3])translate([-2,-3.5,0])cube([4,7,height]);
    }
}