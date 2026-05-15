# 3dEVO - Project Context

## Overview
3dEVO (3D Evolution) is the progressive upgrade of a Chinese Prusa i3 clone (wooden frame) into a capable multi-material 3D printer. The project evolves the machine in phases, each producing a functional printer. Base architecture: Cartesian XZ-head (bed moves Y, hotend moves X/Z).

All design work targets fabrication with the available workshop tools listed below.

## Base Printer Reference
- Chinese Prusa i3 clone, wooden frame (laser-cut plywood/MDF 5-6mm)
- X-rods: 2x 8mm × 370mm, ~45mm vertical center-to-center spacing
- Y-rods: 2x 8mm × 350mm
- Z-rods: 2x 8mm × 320mm + leadscrews
- Build volume: 200 × 200 × 200mm
- Belt system: GT2 6mm (closed-loop 610mm for X, 690mm for Y)
- Motors: NEMA 17 (5x total)
- See `docs/DIMENSIONS_BASELINE.md` for full reference

## Hotend
- Model: **XCR3D 2IN1-S1** (dual filament in, single nozzle out, color switch)
- Body: 30 × 18 × 62mm (W × D × H)
- Heatsink height: 42mm
- Total height to nozzle: 61.6mm
- Mounting: 4× M3, pattern 24mm horizontal × 35mm vertical
- M4 side securing screw
- Weight: 43g
- Feeding: Bowden (long-distance), 1.75mm filament, 0.4mm nozzle
- Compatible extruders: Titan, Bulldog, MK8

## Available Manufacturing Tools

### FDM 3D Printer
- Materials: PLA (black, white, 0.7kg each), TPU
- Use for: structural brackets, housings, gears, custom adapters, complex geometries
- Constraints: layer-based fabrication, limited overhang without supports, anisotropic strength (weak between layers)

### CNC 1080 (Small Format)
- Tools: Spindle (milling), Laser (cutting)
- Laser capability: cutting thin wood, plywood, MDF, acrylic
- Spindle capability: milling wood, plastics, soft aluminum (with care)
- Work area: ~1000x800mm
- Use for: flat structural plates, frames, mounting panels, precision 2D parts

## Software Tools

### OpenSCAD
- Parametric 3D CAD modeler using scripting language
- Use for: designing all 3D-printable parts and 2D profiles (DXF) for laser/CNC
- Output formats: STL (3D printing), DXF (laser/CNC 2D cuts), SVG
- Approach: code-based parametric design — all dimensions as variables for easy iteration
- File extension: `.scad`
- Conventions:
  - One part per file, or use modules for multi-part assemblies
  - All critical dimensions as named variables at top of file
  - Use `$fn` for curve resolution (draft: 32-48, final: 128)
  - Include a `render_part` variable to toggle between assembled/exploded/individual part export

## Design Principles

### General
- Design for manufacturability with available tools
- Prefer modular assemblies that can be fabricated in parts and assembled
- Use standard metric fasteners (M3, M4, M5) for joints
- Keep tolerances achievable: 3D print ±0.2mm, CNC ±0.1mm
- Document all parts with material, process, and assembly notes
- Prioritize components from available BOM (`docs/BOM_AVAILABLE.md`)

### Print Design Rules (learned from X-carriage iterations)
- **NO SUPPORTS**: all parts must be printable without supports. Orient and split parts to achieve this.
- **Clamshell splits**: when a part needs to capture round objects (bearings, rods), split along the centerline into two halves that bolt together. Each half is a half-pipe — prints flat without overhang.
- **Screw positions**: never place screw holes through bearing bores or other functional features. Place them in solid material zones between functional areas.
- **Closed-loop belts**: cannot be threaded through closed channels. Design open grooves that are closed by a mating piece.
- **Mating geometry**: every protrusion on one piece MUST have a matching recess in the other piece. Verify coordinate directions — `rotate([90,0,0])` points -Y, `rotate([-90,0,0])` points +Y.
- **Alignment pins**: always include 2+ pins between mating pieces for registration before screwing.
- **Belt clamping (GT2 closed loop)**: both belt runs stack in a SINGLE groove, teeth facing outward. GT2 ridges on groove floor grip one run, ridges on pressure rib grip the other. No need for two separate grooves.
- **Heat-set M3 brass inserts**: use for all threaded connections in PLA. Cavity: 4.8mm diameter, 5-5.5mm deep.

### Assembly Design Rules
- Parts must be assemblable in logical sequence (bearings first, then rods, then belt, then close)
- Each fastener must be accessible with standard hex keys after full assembly
- Design for serviceability — belt tension, bearing replacement, hotend swap without disassembly of unrelated parts

## File Organization
```
/docs              - Project documentation, specs, calculations
/parts/lib         - Shared OpenSCAD libraries (fasteners, bearings, common)
/parts/x-carriage  - X-axis carriage sub-project
/parts/...         - Future sub-projects
/assemblies        - Assembly documentation and exploded views
/firmware          - Control software (if applicable)
/tools             - Jigs, fixtures, and manufacturing aids
```

## Conventions
- Units: millimeters (mm) for dimensions, degrees for angles
- Coordinate system: right-hand rule, Z-up
- File naming: `<component>_<part-name>_<version>` (e.g., `x_carriage_base_v1`)
- Versions: increment on significant design changes
- OpenSCAD `render_part` variable values: `"assembly"`, `"exploded"`, `"front_half"`, `"back_half"`, `"print_layout"`, or individual part names
- Ghost/reference geometry: use `%` (transparent) for rods, bearings, etc. in assembly views
- Colors: `"dimgray"` for main structural parts, `"steelblue"` for mating/cap pieces, `"white"` for fan ducts

## Current State & Sub-Projects

### X-Carriage (Phase 3 — in progress)
- Location: `parts/x-carriage/`
- Architecture: 3-layer modular system
  - Layer 1: Clamshell base (front_half + back_half) — rides on rods, locks belt
  - Layer 2: Hotend plate — mounts XCR3D 2IN1-S1, probe slot, ADXL345
  - Layer 3: Fan duct — heatsink fan + part cooling (2× 3010 fans)
  - Probe adapters: BLTouch and Eddy Duo (interchangeable)
- Interface: Layer1↔Layer2 via 4× M3 inserts (20mm × 30mm pattern)
- Target weight: <120g carriage + 43g hotend = <163g moving mass

### Evolution Phases (planned)
```
Phase 1: Frame reinforcement (2020 extrusion + laser-cut panels)
Phase 2: Motion upgrade (new bearings, Z-leadscrew 350mm, belt tensioning)
Phase 3: Toolhead (X-carriage + XCR3D hotend + Eddy Duo + cooling) ← CURRENT
Phase 4: Multi-material (3× Titan extruders, filament switching)
Phase 5: Electronics (32-bit + CAN bus + AS5600 encoders)
Phase 6: Enclosure & refinement
```

## Key Reference Documents
- `docs/BOM_AVAILABLE.md` — Inventory/preferred picking list
- `docs/BOM_FINAL.md` — Assembly BOM template (AVAILABLE / PRINT / CUT / TO BUY)
- `docs/BASE_PRINTER.md` — Clone specs, weaknesses, upgrade path
- `docs/DIMENSIONS_BASELINE.md` — All baseline rod/frame/axis dimensions
- `docs/MANUFACTURING_PROFILES.md` — Print/laser/CNC parameter profiles
- `docs/PROJECT.md` — Design rules, material guide, OpenSCAD standards
