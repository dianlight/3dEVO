# 3dEVO - Project Documentation

## 1. Design Rules

### 1.1 General Constraints
| Parameter | Value | Notes |
|-----------|-------|-------|
| Max 3D print volume | Printer-dependent | Verify bed size before designing |
| Max CNC work area | 1000 x 800 mm | Effective cutting area |
| Max laser cut thickness | ~5 mm (wood/plywood) | Depends on material density |
| Max spindle depth | ~10 mm per pass | Conservative for small CNC |
| Preferred fasteners | M3, M4, M5 metric | Socket head cap screws (ISO 4762) |
| Minimum wall thickness (PLA) | 1.2 mm (3 perimeters @ 0.4mm nozzle) | |
| Minimum wall thickness (TPU) | 1.6 mm | Flexible material needs more bulk |

### 1.2 3D Printing Design Rules
- **Orientation**: Design parts so critical surfaces face up or sideways (no supports needed)
- **Overhangs**: Max 45 degrees without support; redesign or split part if steeper
- **Bridges**: Max 20 mm unsupported span
- **Holes**: Horizontal holes < 8mm may need to be drilled post-print for accuracy
- **Tolerances**: Interference fit = nominal - 0.1mm; Clearance fit = nominal + 0.2mm
- **Layer adhesion**: Avoid loading parts in Z-direction where possible; orient for strength
- **Infill**: Structural parts 40-60%; Non-structural 15-20%
- **Screw inserts**: Use heat-set brass inserts (M3/M4) for threaded connections in plastic

### 1.3 CNC/Laser Design Rules
- **Kerf compensation**: Laser ~0.2mm; adjust dimensions accordingly
- **Tab connections**: Use tabs (2-3mm wide) to hold parts during laser cutting; sand after removal
- **Internal corners**: Minimum radius = tool radius (spindle); use dogbone relief for square joints
- **Finger joints**: For box assemblies, material thickness +0.1mm for snug fit
- **Hold-down**: Design parts with clamping margins or use sacrificial base
- **Feed/speed**: Conservative settings first; increase with experience on material

### 1.4 Assembly Design Rules
- **Modularity**: Break complex assemblies into sub-assemblies of max 5-7 parts
- **Accessibility**: Ensure all fasteners are reachable with standard tools after assembly
- **Alignment features**: Use pins, dowels, or registration features for repeatable alignment
- **Serviceability**: Design for disassembly; avoid permanent bonds where possible
- **Cable routing**: Plan channels and clip points for wiring from the start

## 2. Material Selection Guide

| Material | Process | Strength | Flexibility | Use Case |
|----------|---------|----------|-------------|----------|
| PLA | 3D Print | Medium-High | Low (brittle) | Structural parts, housings, brackets |
| TPU | 3D Print | Low | High | Vibration dampeners, grips, flexible joints |
| Plywood 3mm | Laser | Medium | None | Flat frames, panels, enclosures |
| Plywood 5mm | Laser | High | None | Structural plates, bases |
| MDF 3mm | Laser | Low-Medium | None | Prototyping, non-structural panels |
| Soft wood | CNC spindle | Medium | None | Larger structural elements |

## 3. Standard Components Library

### Fasteners (keep in stock)
- M3x8, M3x12, M3x16, M3x20 socket head cap screws
- M4x10, M4x16, M4x20, M4x30 socket head cap screws
- M5x16, M5x20, M5x30 socket head cap screws
- M3, M4, M5 nuts (standard and nyloc)
- M3, M4, M5 washers
- M3, M4 heat-set brass inserts

### Bearings & Linear Motion
- 608ZZ bearings (8x22x7mm) - common, cheap
- LM8UU linear bearings (8mm shaft)
- 6mm/8mm smooth rods
- GT2 timing belts and pulleys

### Electronics (if applicable)
- NEMA 17 stepper motors
- A4988 / TMC2209 stepper drivers
- Microcontrollers: Arduino / ESP32 / STM32
- Limit switches, endstops

## 4. Documentation Standards

Each designed part must include:
1. **Part name and version**
2. **Material and manufacturing process**
3. **Critical dimensions and tolerances**
4. **Assembly notes** (orientation, mating parts)
5. **Post-processing** (sanding, drilling, tapping)

Each assembly must include:
1. **Bill of Materials (BOM)**
2. **Assembly sequence**
3. **Required tools**
4. **Alignment/calibration procedure**

## 5. OpenSCAD Design Standards

### File Structure Template
```openscad
// Part: <name>
// Version: <vX>
// Process: <3D Print | Laser | CNC>

/* --- Parameters --- */
wall = 2.0;
height = 30;
tolerance = 0.2;

/* --- Resolution --- */
$fn = $preview ? 32 : 128;

/* --- Modules --- */
module part_name() {
    // geometry here
}

/* --- Render --- */
part_name();
```

### Conventions
- All dimensions in mm (OpenSCAD is unitless; we treat 1 unit = 1 mm)
- Parametric first: no magic numbers in geometry, always named variables
- Use `difference()` for subtractive features (holes, pockets)
- Use `hull()` and `minkowski()` sparingly (expensive operations)
- For laser-cut parts: design as 2D with `linear_extrude(material_thickness)`
- Export STL for 3D printing, DXF (2D projection) for laser/CNC
- Use `color()` in assemblies for visual clarity during preview
- Comment non-obvious geometry decisions only

### Library Modules (shared across parts)
Create reusable modules in `/parts/lib/`:
- `fasteners.scad` - M3/M4/M5 hole profiles, counterbores, heat-set insert cavities
- `bearings.scad` - 608ZZ, LM8UU housing geometries
- `common.scad` - rounded rectangles, fillet helpers, slot profiles

## 6. Version Control
- All design files tracked in this repository
- Commit messages: `[component] brief description of change`
- Tag releases when assemblies are verified functional
