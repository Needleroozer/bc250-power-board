
module half_connector() {
    render() // this intersection gets screwy; forcing a render() helps runtime
    intersection() {
        //86 pins becomes 43 pins wide; 50 becomes 25. Pin pitch is 0.1"
        translate([2.54*(25-43)/2, 0, 0])
        //hahaha the model isn't centered
        translate([-.07, 0, 0]) import("WingTAT-86L.stl");
        
        translate([0, -40, -60])
        cube(80);
    }
}

half_connector();
mirror([1,0,0]) half_connector();