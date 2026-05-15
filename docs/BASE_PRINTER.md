# 3dEVO - Base Printer: Prusa i3 Clone (Wooden Frame)

## Source Reference
- Design: [RepRap Prusa i3](https://reprap.org/wiki/Prusa_i3)
- Variant: Chinese clone, wooden frame (laser-cut plywood/MDF)

---

## Base Architecture

### Kinematics: Cartesian XZ-Head
```
        Z (vertical, 2x leadscrews)
        |
        |   X (horizontal, belt-driven, carries hotend)
        |  /
        | /
        +---------> 
       /
      / Y (bed moves front-back, belt-driven)
```

- **X-axis**: Hotend carriage on smooth rods, belt-driven, mounted on Z carriages
- **Y-axis**: Heated bed on smooth rods, belt-driven, frame-mounted
- **Z-axis**: Two leadscrews (coupled to same driver), lifting the X-axis assembly

### Typical Clone Specifications
| Parameter | Value |
|-----------|-------|
| Build volume | ~200 x 200 x 200 mm |
| Frame material | Laser-cut plywood or MDF, 5-6mm |
| X/Y rods | 8mm smooth rods |
| Z rods | 8mm smooth rods + M5 or T8 leadscrews |
| X/Y bearings | LM8UU or polymer equivalent |
| Z bearings | LM8UU |
| Motors | 5x NEMA 17 (X, Y, Z1, Z2 coupled, Extruder) |
| Belts | GT2 6mm |
| Electronics | RAMPS 1.4 / MKS Gen / similar 8-bit board |
| Firmware | Marlin (typically) |
| Hotend | E3D V6 clone or J-head |
| Extruder | Direct drive or Bowden (varies) |
| Bed | Aluminum plate + heated PCB, 200x200mm |
| PSU | 12V or 24V (varies by clone) |

---

## Known Weaknesses of Wooden Frame i3 Clones

| Issue | Impact | Solution Direction |
|-------|--------|-------------------|
| Frame flex (wood) | Z-banding, ringing artifacts | Stiffen or replace frame |
| Poor Z-alignment | 2 leadscrews bind if not parallel | Anti-backlash nuts, flexible couplers, or single-leadscrew |
| X-carriage weight | Ringing at speed | Lighten carriage, reduce moving mass |
| Single extruder | No multi-material | Add tool-change or multi-extruder system |
| 8-bit electronics | Limited features, slow processing | Upgrade to 32-bit + CAN bus |
| No bed probe | Manual leveling, inconsistent first layer | Add auto-bed-leveling (Eddy Duo available) |
| No filament sensor | Failed prints from runout | Add break detection (available x2) |
| Open frame | No enclosure, poor thermal stability | Add panels/enclosure |
| Cheap bearings | Noise, play, wear | Replace with quality LM8UU or polymer bearings |

---

## What We Keep (Reusable from clone)

- NEMA 17 motor mounting pattern (standard 31mm hole spacing)
- GT2 belt system (compatible with available pulleys)
- 8mm rod system (compatible with available LMK8UU / RJ4JP bearings)
- Heated bed (if functional)
- PSU (if adequate wattage)
- Basic wiring harness (adapt with GX16 connectors)

## What We Replace/Upgrade

Priority targets based on available BOM:
1. **Frame** → Rebuild with 2020 extrusion + corner brackets (partial), or reinforced laser-cut panels
2. **Bearings** → RJ4JP-01-08 (polymer, silent) replacing cheap LM8UU
3. **Z-axis** → Lead screw 2mm pitch 350mm (available) for finer resolution
4. **Extruder** → Titan extruder(s) (x3 available) — multi-material capability
5. **Probe** → BIGTREETECH Eddy Duo for auto bed leveling
6. **Filament sensor** → Break detection modules (x2 available)
7. **Electronics** → CAN bus architecture (MCP2515 available) + AS5600 encoders
8. **Connectors** → GX16 5-pin for modular cable management
9. **Cooling** → 3010 fans (12V/5V options available)

---

## Evolution Path (3dEVO Concept)

```
Phase 0: Document current state, identify reusable parts
    │
Phase 1: Frame reinforcement / replacement
    │     (rigidity is prerequisite for everything else)
    │
Phase 2: Motion system upgrade
    │     (new bearings, Z-leadscrew, belt tensioning)
    │
Phase 3: Extruder / toolhead upgrade
    │     (Titan extruder, new cooling, Eddy probe)
    │
Phase 4: Multi-material system
    │     (3x Titan, filament switching, break detection)
    │
Phase 5: Electronics & firmware
    │     (32-bit board, CAN bus, AS5600 encoders, closed-loop)
    │
Phase 6: Enclosure & refinement
          (panels, cable management, tuning)
```

Each phase should result in a functional printer — no phase leaves the machine inoperable.
