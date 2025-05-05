$fn=30;


include <Getriebe.scad>;

module rolle(){
    triangle_points =[[0,0],[7,5],[7,-5]];
    triangle_paths =[[0,1,2]];
    anzahl = 72;

    difference()
    {
        union(){
            cylinder(8,r=20,center=true);
        }
        union()
        {
            rotate_extrude()translate([16,0,0])polygon(triangle_points,triangle_paths,10);
            cylinder(39,r=4.3,center=true);
        }
    }

    segment=360/anzahl;
    for(i=[0:anzahl-1]){
        rotate([0,33,i*segment])translate([15.5,0,8.5])spitze();
        rotate([0,-33,i*segment])translate([15.5,0,-8.5])spitze();
    }
    //translate([7,0,0])cube([8,8,8],true);
    //translate([-7,0,0])cube([8,8,8],true);    


}

module spitze(){
        rotate([45,0,0])cube([5,1,1],true);
    }

intersection(){

    rolle();
    translate([0,0,-5])stirnrad (modul=1, zahnzahl=38, breite=10, bohrung=4, eingriffswinkel=20, schraegungswinkel=20, optimiert=false);
}

translate([50,0,-5])stirnrad (modul=1, zahnzahl=38/2, breite=10, bohrung=4, eingriffswinkel=20, schraegungswinkel=20, optimiert=false);