difference(){
    scale([1,0.4,1])cylinder(3,50,50);
    union(){
        translate([30,0,0])cylinder(10,4.5,4.5,true);
        translate([-30,0,0])cylinder(10,4.5,4.5,true);
    }
}