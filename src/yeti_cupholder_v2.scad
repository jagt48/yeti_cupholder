$fn=200;

wall_thickness = 4;

base_height = 80;
base_bottom_diameter = 70;
base_top_diameter = 75;

top_height = 20;
top_bottom_diameter = 106;
top_top_diameter = 110;

mid_height = 10;
mid_bottom_diameter = base_top_diameter;
mid_top_diameter = top_bottom_diameter;

difference()
{
    union(){

    // Base
    cylinder(h=base_height,
             r1=base_bottom_diameter/2,
             r2=base_top_diameter/2);
    
    // Mid
    translate([0,0,base_height])
    offset_cylinder(mid_bottom_diameter,
                    mid_top_diameter,
                    mid_height);
        


    translate([(mid_top_diameter - mid_bottom_diameter)/2,
               0,
               base_height+mid_height])
    difference()
    {
        {   // Top
            cylinder(h=top_height,
                     r1=top_bottom_diameter/2,
                     r2=top_top_diameter/2);
            
            translate([0,0,wall_thickness])
            cylinder(h=top_height,
                     r1=top_bottom_diameter/2 - wall_thickness/2,
                     r2=top_top_diameter/2 - wall_thickness/2);
        }
    }
    }
    
    // Hollow
    translate([0,0,wall_thickness])
        cylinder(h=base_height+wall_thickness+50,
                 r1=base_bottom_diameter/2 - wall_thickness/2,
                 r2=base_top_diameter/2 - wall_thickness/2);

// Cutouts in top
{
    translate([(mid_top_diameter - mid_bottom_diameter)/2,
               0,
               base_height+mid_height+wall_thickness+10])
    //rotate([90,0,0])
    //rotate_extrude(angle=30,convexity=2)
    linear_extrude(top_height)
    square([top_top_diameter +1,30], center=true);
        
    translate([(mid_top_diameter - mid_bottom_diameter)/2,
                0,
                base_height+mid_height+wall_thickness+10])
    rotate([0,0,90])
    //rotate_extrude(angle=30,convexity=2)
    linear_extrude(top_height)
    square([top_top_diameter +1,30], center=true);
    }
}


// Offset Module
// Module: offset_cylinder
// Description: Generates an cylinder with the bottom and top offset from each other in the X-axis
// d_bottom = Diameter of the bottom
// d_top = Diameter of the top
// h = height
module offset_cylinder(d_bottom,d_top,h)
{
    hull()
    {
        cylinder(h=0.001,r=d_bottom/2);
        translate([(d_top - d_bottom)/2,
                   0,
                   h])
        {
            cylinder(h=0.001,r=d_top/2);
        }
    }
}


