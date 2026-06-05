// ==================================================
// PARAMETRIC MEDIEVAL BUCKET STYLE PLANTER
// BY BOYO LABS
// ==================================================

/* [Bucket Dimensions] */
pot_height = 150;       // Total height (mm)
bottom_radius = 85;     // Radius at the very base (mm)
top_radius = 100;       // Radius at the rim (mm) - creates the taper
wall_thickness = 12;    // Heavy-duty walls
floor_thickness = 15;   // Base thickness

/* [Stave Settings] */
stave_count = 14;       // Number of vertical wood planks
stave_gap = 1.2;        // Width of the faux groove between planks (mm)
stave_groove_depth = 2; // How deep the groove cuts into the wall (mm)

/* [Iron Hoop Settings] */
hoop_thickness = 2.5;   // How far the metal bands stick out (mm)
hoop_width = 12;        // Height of the metal bands (mm)
hoop_offset = 15;       // Distance of hoops from top and bottom edges

/* [Drainage] */
drain_hole_radius = 6;  // Bottom drainage
$fn = 64;               // Rendering resolution

module medieval_bucket() {
    inner_bottom_r = bottom_radius - wall_thickness;
    inner_top_r = top_radius - wall_thickness;

    difference() {
        // -------------------------------------------------------
        // 1. ADDITIVE GEOMETRY: Main Cone + Iron Bands
        // -------------------------------------------------------
        union() {
            // The Main Tapered Bucket Body
            cylinder(h=pot_height, r1=bottom_radius, r2=top_radius);
            
            // Bottom Iron Hoop
            translate([0, 0, hoop_offset])
                cylinder(h=hoop_width, 
                         r1=bottom_radius + (top_radius-bottom_radius)*(hoop_offset/pot_height) + hoop_thickness, 
                         r2=bottom_radius + (top_radius-bottom_radius)*((hoop_offset+hoop_width)/pot_height) + hoop_thickness);
            
            // Top Iron Hoop
            translate([0, 0, pot_height - hoop_offset - hoop_width])
                cylinder(h=hoop_width, 
                         r1=bottom_radius + (top_radius-bottom_radius)*((pot_height-hoop_offset-hoop_width)/pot_height) + hoop_thickness, 
                         r2=bottom_radius + (top_radius-bottom_radius)*((pot_height-hoop_offset)/pot_height) + hoop_thickness);
        }

        // -------------------------------------------------------
        // 2. SUBTRACTIVE GEOMETRY: Core, Drainage, & Wood Grooves
        // -------------------------------------------------------
        
        // The Hollow Inside Core (matches the exterior taper)
        translate([0, 0, floor_thickness]) {
            cylinder(h=pot_height - floor_thickness + 1, r1=inner_bottom_r, r2=inner_top_r);
        }
        
        // Drainage Hole
        translate([0, 0, -1]) {
            cylinder(h=floor_thickness + 2, r=drain_hole_radius);
        }
        
        // FIXED: Wood Stave Grooves (Now only scores the outer skin)
        step = 360 / stave_count;
        for (i = [0 : stave_count - 1]) {
            rotate([0, 0, i * step])
                // Position the cutting tool precisely at the outer perimeter of the rim
                translate([-stave_gap/2, inner_top_r + 5, -1])
                    // The depth of the cube is tightly controlled so it can't reach the inside
                    cube([stave_gap, wall_thickness + hoop_thickness + 5, pot_height + 2], center=false);
        }
        
        // Flatten the Stave Faces (converts the round cone into flat facets)
        for (i = [0 : stave_count - 1]) {
            rotate([0, 0, (i * step) + (step / 2)])
                translate([0, top_radius - stave_groove_depth, -1])
                    cube([top_radius, 20, pot_height + 2], center=true);
        }
    }
}

// Render the final medieval bucket
medieval_bucket();
