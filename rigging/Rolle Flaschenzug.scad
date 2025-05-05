$fn=80;
difference(){
    cylinder(8,r=20,center=true);
    union(){
        rotate_extrude()translate([20,0,0])circle(r=3);
        cylinder(9,r=4.3,center=true);
    }
}