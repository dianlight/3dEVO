# 3dEVO - Project Context

## Overview
3dEVO (3D Evolution) is the progressive upgrade of a Chinese Prusa i3 clone (wooden frame) into a capable multi-material 3D printer. The project evolves the machine in phases, each producing a functional printer. Base architecture: Cartesian XZ-head (bed moves Y, hotend moves X/Z).

All design work targets fabrication with the available workshop tools listed below.

## Available Manufacturing Tools

### FDM 3D Printer
- Materials: PLA, TPU (flexible)
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
  - Use `$fn` for curve resolution (draft: 32, final: 128)
  - Include a `render_mode` variable to toggle between assembled/exploded/individual views

## Design Principles
- Design for manufacturability with the tools above
- Prefer modular assemblies that can be fabricated in parts and assembled
- Use standard metric fasteners (M3, M4, M5) for joints
- Keep tolerances achievable: 3D print +/- 0.2mm, CNC +/- 0.1mm
- Document all parts with material, process, and assembly notes

## File Organization
```
/docs        - Project documentation, specs, calculations
/parts       - Individual part designs and drawings
/assemblies  - Assembly documentation and exploded views
/firmware    - Control software (if applicable)
/tools       - Jigs, fixtures, and manufacturing aids
```

## Conventions
- Units: millimeters (mm) for dimensions, degrees for angles
- Coordinate system: right-hand rule, Z-up
- File naming: `<component>_<part-name>_<version>` (e.g., `arm_link1_v2`)
- Versions: increment on significant design changes
