$fn=80;
triangle_points =[[0,0],[7,5],[7,-5]];
triangle_paths =[[0,1,2]];
anzahl = 72;

difference()
{
    union(){
        cylinder(8,r=20,center=true);
        translate([0,0,-4])cylinder(20,r=5,center=false);
        translate([0,0,-4])cylinder(11,r=7,center=false);
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
module spitze(){
    rotate([45,0,0])cube([5,1,1],true);
}