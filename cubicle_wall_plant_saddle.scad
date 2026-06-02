/* ============================================================
   Cubicle Wall Planter Saddle

   A self-contained planter trough that saddles a 3.03" cubicle
   wall. Lofted arms grip both faces of the wall panel.

   Units: mm  (1 inch = 25.4 mm)
   ============================================================ */

$fn = 64;
inch = 25.4;

// ─── Parameters ──────────────────────────────────────────────

wall_thick      = 3.03 * inch;  // cubicle wall thickness          (76.96 mm)
planter_length  = 8.00 * inch;  // planter length along wall        (203.2 mm)
planter_depth   = 6.00 * inch;  // planter depth front-to-back     (152.4 mm)
planter_height  = 5.00 * inch;  // interior soil depth             (127.0 mm)
wall_t          = 5.0;          // planter wall thickness            mm
floor_t         = 8.0;          // planter floor thickness           mm
arm_drop        = 3.50 * inch;  // grip arm length below planter    (88.9 mm)
arm_t           = 6.0;          // grip arm thickness                mm
fit_gap         = 1.5;          // clearance per wall face           mm

// ─── Derived ─────────────────────────────────────────────────

channel      = wall_thick + 2 * fit_gap;              // slot opening (~80 mm)
overhang     = (planter_depth - channel) / 2 - arm_t; // overhang per wall face
total_height = floor_t + planter_height;

assert(overhang >= 0,
  "planter_depth too narrow — increase planter_depth so it clears the wall.");

front_arm_y  = overhang;
back_arm_y   = overhang + arm_t + channel;

// ─── Model ───────────────────────────────────────────────────

module planter_saddle() {
    difference() {
        union() {

            // ── Planter outer shell ──────────────────────────
            // Solid box; interior removed below via difference()
            cube([planter_length, planter_depth, total_height]);

            // ── Lofted front grip arm ────────────────────────
            // z = 0: spans full front overhang (y = 0 → front_arm_y + arm_t)
            // z = -arm_drop: just the grip arm (arm_t thick)
            hull() {
                cube([planter_length, front_arm_y + arm_t, 0.1]);
                translate([0, front_arm_y, -arm_drop])
                    cube([planter_length, arm_t, 0.1]);
            }

            // ── Lofted back grip arm ─────────────────────────
            // z = 0: spans full back overhang (y = back_arm_y → planter_depth)
            // z = -arm_drop: just the grip arm (arm_t thick)
            hull() {
                translate([0, back_arm_y, 0])
                    cube([planter_length, planter_depth - back_arm_y, 0.1]);
                translate([0, back_arm_y, -arm_drop])
                    cube([planter_length, arm_t, 0.1]);
            }
        }

        // ── Interior cavity (soil space) ─────────────────────
        // Starts at floor_t, leaving a solid floor; open at the top
        translate([wall_t, wall_t, floor_t])
            cube([planter_length - 2 * wall_t,
                  planter_depth  - 2 * wall_t,
                  planter_height + 1]);         // +1 ensures clean open top

    }
}

// Center on X/Y for display; arms hang in -Z
translate([-planter_length / 2, -planter_depth / 2, 0])
    planter_saddle();


/* ─── Key dimensions ───────────────────────────────────────────
   Outer shell:      8.0" × 6.0" × (floor + 5.0" walls)
   Interior (soil):  ~7.6" × ~5.6" × 5.0" deep
   Wall slot:        ~80 mm / ~3.15" (3.03" wall + 1.5 mm per side)
   Arm drop:         2.5" below planter floor
   ─────────────────────────────────────────────────────────── */
