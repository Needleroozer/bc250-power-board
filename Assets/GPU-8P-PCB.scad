peg_width = 3.4;
peg_pitch = 4.2;
peg_height = 9.1 + 0.01;

module square_peg(x=0, y=0, z=peg_height) {
    module half_square() {
        translate([0, peg_width/2])
        scale([peg_width/687, peg_width/687])
        polygon([[0, 0], [346, 0], [346, -687], [0, -687], 
        [0, -568], [77, -568], [176, -471], [176, -417], [253, -417], [253, -197], [176, -197], [176, -130], [0, -130], [0, 0]]);
    }    
    
    translate([x*peg_pitch, y*peg_pitch, 0])
    linear_extrude(z)
    union() {
        half_square();
        mirror([-180, 0]) half_square();
    }
}

// dimensions pulled from a screenshot of Molex 444750411_sd.pdf
module hex_peg(x=0, y=0, z=peg_height) {
    module half_hex() {
        translate([0, peg_width/2])
        scale([peg_width/687, peg_width/687])
        polygon([[0, 0], [346, 0], [346, -485], [143, -687], [0, -687],
        [0, -568], [77, -568], [176, -471], [176, -417], [253, -417], [253, -197], [176, -197], [176, -130], [0, -130], [0, 0]]);
    }
    
    translate([x*peg_pitch, y*peg_pitch, 0])
    linear_extrude(z)
    union() {
        half_hex();
        mirror([-180, 0]) half_hex();
    }
}

module contact() {
    // 3.2 lower, 3.9 upper (measuring \/ spread)
    // 1.4 x 2.8 leads
    translate([-0.7, peg_pitch/2 - 3.2/2, 0])
    rotate([180 - asin(.35/2.8), 0, 0])
    cube([1.4, .15, 2.8]);
}   

//Actual pins
translate([0, 0, -0.01])
union() {
    square_peg(0,0);
    hex_peg(0, 1);
    hex_peg(1,0);
    hex_peg(1,1);
    hex_peg(2,0);
    square_peg(2,1);
    hex_peg(3,0);
    square_peg(3,1);

    // bridge piece
    translate([2*peg_pitch, peg_width/2 + peg_pitch - 0.55, 0])
    cube([4, .55, peg_height]);
}

// Base
translate([1.5*peg_pitch, peg_pitch/2, -4/2]) 
difference() {
    cube([18, 11.5, 4], center = true);
    translate([0, 1 + 11.5/2 - (11.5 - 10.6), 0])
    cube([3, 2, 5], center=true);
}

// Contacts
for (i = [0:3])
{
    translate([i*peg_pitch, 0, -3.99]) contact();
    translate([i*peg_pitch, peg_pitch, -3.99]) rotate([0, 0, 180]) contact();
}

