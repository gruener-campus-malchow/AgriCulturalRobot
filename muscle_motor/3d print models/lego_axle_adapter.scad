$fn=50;

difference(){
    union(){
        //cylinder(3,d=16,center=true);
        translate([0,0,-2])cylinder(7,4,8,center=true);
    }
    
    union(){
        translate([0,0,-0])nut(6,3,0.1);
        translate([0,0,-5])lego_axle(22);
    }
}

module nut(size, height, toleranz){
    factor = size/4;
    scale([factor+toleranz,factor+toleranz,1])union(){
        color("blue") translate([-2,-3.5,0])cube([4,7,height]);
        color("blue") rotate([0,0,180/3])translate([-2,-3.5,0])cube([4,7,height]);
        color("blue") rotate([0,0,-180/3])translate([-2,-3.5,0])cube([4,7,height]);
    }
}

module lego_axle(length){    
    axle_dia = 4.9; // prumer axle. Mozna ale 4.75
    axle_rib = axle_dia/3;  // "zebro", tj. tloustka steny axle 
    //axle_len = 15.6/2;    // delka axle s delkou 1 Lego unit = orig. lego rozmery
    axle_len = length;           // pro ladeni rozmeru to budeme tisknout nizsi
    cube([axle_rib, axle_dia, axle_len], true);
    rotate(90) cube([axle_rib, axle_dia, axle_len], true);
}
    
    