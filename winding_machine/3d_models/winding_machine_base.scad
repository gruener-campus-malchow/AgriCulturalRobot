

base_x = 100;
base_y = 50;
base_z = 5;
base_t = 5;
base_height = 30;

servo_mount_strength = 2;
servo_mount_width = 5;
servo_mount_gap = 2.5;
servo_mount_holes_offset = 2.5;

servo_y = 22;
servo_z = 11;
servo_x = 22;
servo_connector = 4;
servo_con_height = 3;
servo_gear_height = 4;

coil_holder_diameter = 20;

$fn=30;

visible();
//coil_adapter();



module coil_adapter(){
    difference(){
       cylinder(5, d= coil_holder_diameter, center = true) ;
        union(){
            translate([5,-1.5,-3])cube([5,3.5,15]);
            translate([-10,-1.5,-3])cube([5,3.5,15]);
            
            translate([0,0,-2])cylinder(5,d=7,center=true);
            
            translate([0,0,-5])cylinder(20,d=3.5,center=true);
            translate([0,0,2]) nut(6.5,6,0);
        }
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

module visible()
{
    base();
    translate([0,0,base_height+base_t])cap();
    translate([base_x/2-servo_x+3.5,base_y/2-servo_y/2,base_height+base_t*2])servo();
    
    translate([base_x/2-6-5,0,base_height+base_t*2])color("purple")laser_fork();
    translate([base_x/2+20,0,base_height+base_t*2])color("purple")laser_fork();
    
    translate([base_x/2 + servo_x/1.5, base_y/2-servo_y/2 + servo_z/2, base_height+2*base_z + 0.5*servo_z])rotate([0,90,0])coil_holder();
    translate([base_x/2 + servo_x, base_y/2-servo_y/2 + servo_z/2, base_height+2*base_z + 0.5*servo_z])rotate([0,90,0])coil_adapter();
}

module servo()
{
    color("blue")cube([servo_x,servo_y,servo_z]);
    translate([servo_x,servo_z/2,servo_z/2]) rotate([0,90,0]) color("blue")cylinder(servo_gear_height, d = servo_z);
    translate([servo_x+servo_gear_height,servo_z/2,servo_z/2]) rotate([0,90,0]) color("grey")cylinder(servo_con_height, d = servo_connector);
    //axis
    translate([servo_x+servo_con_height,servo_z/2,servo_z/2]) rotate([0,90,0]) color("red")cylinder(20, d = 1);
}

module base(){
        difference(){
            cube([base_x,base_y,base_z]);
            translate([base_t,base_t,-0.5])cube([base_x-2*base_t,base_y-2*base_t,base_z+1]);
        }

        edge_square(base_height,base_t,45);
}

module edge_square(height,thickness, distance)
{
    pillar(thickness,thickness,height);
    translate([0,distance,0])pillar(thickness,thickness,height);
    translate([distance,distance,0])pillar(thickness,thickness,height);
    translate([distance,0,0])pillar(thickness,thickness,height);    
}

module cap(){
    difference()
    {
        cube([base_y,base_y,base_z]);
        union()
        {
            translate([base_t,base_t,-base_t/2])cube([base_y-5*base_t,base_y-2*base_t,base_z+base_t]);
            //mounting holes
            translate([base_y - base_t/2,base_t/2,-base_t])cylinder(20,d=servo_mount_strength);
            translate([base_t/2, base_y - base_t/2,-base_t])cylinder(20,d=servo_mount_strength);
            translate([base_y - base_t/2, base_y - base_t/2,-base_t])cylinder(20,d=servo_mount_strength);
            translate([base_t/2,base_t/2,-base_t]) cylinder(20,d=1);
        }
    }
    //rechts
    servo_clamp();
    //links
    translate([0,base_y,0])mirror([0,1,0])servo_clamp();
        
}

module servo_clamp()
{
     difference(){
        union(){
            translate([base_y-servo_mount_strength,base_y/2+servo_y/2,base_z])cube([servo_mount_strength,servo_mount_width,servo_z]);
            translate([base_y-servo_mount_strength-servo_mount_gap-servo_mount_strength,base_y/2+servo_y/2,base_z])cube([servo_mount_strength,servo_mount_width,servo_z]);
        }
        translate([base_y-(2*servo_mount_strength + servo_mount_gap),base_y/2+servo_y/2+servo_mount_holes_offset,base_z + servo_z/2-servo_mount_width/6])rotate([0,90,0])cylinder(15,d=2,center=true);
    }
    
    translate([base_y-(2*servo_mount_strength + servo_mount_gap),base_y/2+servo_y/2+servo_mount_width,base_z])cube([2*servo_mount_strength + servo_mount_gap,servo_mount_strength,servo_z]);
}

module pillar(thickness,thickness,height)
{
    difference()
    {
        translate([0,0,0])cube([thickness,thickness,height]);
        translate([thickness/2,thickness/2,height/2])cylinder(20,d=servo_mount_strength);
    }
}

module laser_fork()
{
    cube([6,3,20]);
    translate([0,4.5,0])cube([6,3,20]);
}

module coil_holder()
{
    difference()
    {
        union(){
            cylinder(1, d = coil_holder_diameter, center=true);
            cube([40,5,1],true);
            translate([0,0,-3.5])cylinder(3, d = servo_z);
            
            translate([6,-1.5,0])cube([3,3,5]);
            translate([-9,-1.5,0])cube([3,3,5]);
        }
        union(){
            cylinder(20, d = 1.5, center=true);
            translate([0,0,-4.5])cylinder(4, d = servo_connector+0.5);
        }
        
    }
}