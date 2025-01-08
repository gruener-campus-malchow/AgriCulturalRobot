$fn=50;

pulley_size=50;
axis_dia=8;
offset_a = 0.5;



difference()
{
    cube([pulley_size,pulley_size,pulley_size],true);
    cylinder(pulley_size*2,d=axis_dia+offset_a, center = true);
}