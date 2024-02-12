base_x = 100;
base_y = 50;
base_z = 5;
base_t = 5;
base_height = 30;

servo_mount_strength = 2;
servo_mount_width = 5;
servo_mount_gap = 2.5;

servo_y = 22;
servo_z = 11;


$fn=30;

base();

translate([0,0,base_height+base_t])cap();


module base(){
        difference(){
            cube([base_x,base_y,base_z]);
            translate([base_t,base_t,-0.5])cube([base_x-2*base_t,base_y-2*base_t,base_z+1]);
        }

        edge_square(base_height,base_t,45);
}





module edge_square(height,thickness, distance)
{
    translate([0,distance,0])cube([thickness,thickness,height]);
    translate([distance,distance,0])cube([thickness,thickness,height]);
    translate([distance,0,0])cube([thickness,thickness,height]);
    translate([0,0,0])cube([thickness,thickness,height]);
}

module cap(){
    cube([base_y,base_y,base_z]);
    translate([base_y-servo_mount_strength,base_y/2+servo_y/2,base_z])cube([servo_mount_strength,servo_mount_width,servo_z]);
    translate([base_y-servo_mount_strength,base_y/2-servo_y/2-servo_mount_width,base_z])cube([servo_mount_strength,servo_mount_width,servo_z]);
    translate([base_y-servo_mount_strength-servo_mount_gap-servo_mount_strength,base_y/2+servo_y/2,base_z])cube([servo_mount_strength,servo_mount_width,servo_z]);
    translate([base_y-servo_mount_strength-servo_mount_gap-servo_mount_strength,base_y/2-servo_y/2-servo_mount_width,base_z])cube([servo_mount_strength,servo_mount_width,servo_z]);
    
    translate([base_y-(2*servo_mount_strength + servo_mount_gap),base_y/2-servo_y/2-servo_mount_width-servo_mount_strength,base_z])cube([2*servo_mount_strength + servo_mount_gap,servo_mount_strength,servo_z]);
    
    translate([base_y-(2*servo_mount_strength + servo_mount_gap),base_y/2+servo_y/2+servo_mount_width,base_z])cube([2*servo_mount_strength + servo_mount_gap,servo_mount_strength,servo_z]);
    
    // HIER MÜSSEN LÖCHER MODELLIERT WERDEN
    
}