# X-Carriage Modular Assembly v1

## Overview

Modular 3-layer X-carriage system for the 3dEVO printer, designed to mount the XCR3D 2IN1-S1 dual-filament hotend on a Prusa i3 style X-axis (8mm rods, 45mm spacing).

---

## Architecture

```
┌─────────────────────────────────────────┐
│  LAYER 1: CARRIAGE BASE                 │  Rides on 8mm X-rods
│  x_carriage_base_v1.scad                │  Holds GT2 belt
│  PLA Black, Structural                  │  M3 inserts interface
├─────────────────────────────────────────┤
│  LAYER 2: HOTEND PLATE                  │  Mounts XCR3D 2IN1-S1
│  x_carriage_hotend_plate_v1.scad        │  Probe slot (right side)
│  PLA Black, Structural                  │  ADXL345 mount (top)
├─────────────────────────────────────────┤
│  LAYER 3: FAN DUCT                      │  Heatsink fan (3010)
│  x_carriage_fan_duct_v1.scad            │  Part cooling duct
│  PLA White, Standard                    │  M2.5 clip mount
└─────────────────────────────────────────┘
     + PROBE ADAPTER (choose one):
       - x_carriage_probe_bltouch_v1.scad
       - x_carriage_probe_eddy_v1.scad
```

---

## Sub-Project BOM

### Printed Parts

| # | Part | File | Material | Profile | Est. Time | Est. Weight |
|---|------|------|----------|---------|-----------|-------------|
| 1 | Carriage Base | x_carriage_base_v1.scad | PLA Black | Structural (4 walls, 50%) | ~2h | ~35g |
| 2 | Hotend Plate | x_carriage_hotend_plate_v1.scad | PLA Black | Structural (4 walls, 50%) | ~1.5h | ~25g |
| 3 | Fan Duct | x_carriage_fan_duct_v1.scad | PLA White | Standard (3 walls, 20%) | ~1.5h | ~20g |
| 4 | Probe Adapter | _bltouch or _eddy | PLA Black | Standard | ~30min | ~8g |

**Total printed mass: ~88g**

### Hardware - AVAILABLE (from BOM)

| # | Item | Qty | BOM Ref | Notes |
|---|------|-----|---------|-------|
| 1 | M3 Brass Heat-Set Inserts | 4 | 5.5 | Layer 1 interface |
| 2 | M3x12 screws | 4 | 5.3/5.4 | Layer 2 to Layer 1 |
| 3 | M3x8 screws | 4 | 5.3 | Hotend to plate |
| 4 | M2.5x8 screws | 4 | 5.4 | Fan duct + ADXL345 |
| 5 | M3x10 screws | 2 | 5.3 | Probe adapter to plate |
| 6 | Fan 3010 12V 3-pin | 1 | 11.2 | Heatsink cooling |
| 7 | Fan 3010 12V 2-pin | 1 | 11.1 | Part cooling |
| 8 | RJ4JP-01-08 bearings | 2-3 | 2.3 | X-rod linear bearings |
| 9 | BIGTREETECH Eddy Duo | 1 | 9.1 | Bed probe (OR BLTouch) |

### Hardware - TO BUY

| # | Item | Qty | Notes | Priority |
|---|------|-----|-------|----------|
| 1 | XCR3D 2IN1-S1 Hotend | 1 | Dual-filament hotend | HIGH |
| 2 | ADXL345 breakout board | 1 | Accelerometer for input shaping | MEDIUM |
| 3 | M3 self-tapping screws (8mm) | 4 | Fan mounting into plastic | LOW (optional) |
| 4 | Zip ties (small) | 5 | Cable management | LOW |

---

## Assembly Sequence

### Tools Required
- Soldering iron (for heat-set inserts)
- Hex keys: 1.5mm (M2.5), 2mm (M3)
- Small pliers (belt clamp)

### Steps

1. **Prepare Base (Layer 1)**
   - Install 4x M3 brass heat-set inserts into front face holes (use soldering iron at 220C)
   - Verify inserts are flush and perpendicular
   - Test-fit on 8mm X-rods — should slide freely with no wobble

2. **Prepare Hotend Plate (Layer 2)**
   - Test-fit XCR3D 2IN1-S1 in the mount holes (4x M3 at 24x35mm)
   - Verify ADXL345 M2.5 holes align with breakout board

3. **Mount Hotend to Plate**
   - Insert XCR3D from the back of plate
   - Secure with 4x M3x8 screws from front

4. **Attach Plate to Base**
   - Align plate with base front face
   - Secure with 4x M3x12 screws into heat-set inserts
   - Verify plate is square to base

5. **Install Probe Adapter**
   - Choose BLTouch or Eddy Duo adapter
   - Attach to plate right-side mount with 2x M3x10 screws
   - Mount probe sensor to adapter
   - Record nozzle-to-probe X/Y offset for firmware

6. **Install Fan Duct (Layer 3)**
   - Mount heatsink fan (3010, 12V 3-pin) to duct rear face with M2.5 screws
   - Attach duct assembly to hotend plate with 2x M2.5 screws
   - Mount part cooling fan (3010, 12V 2-pin)
   - Verify heatsink fan blows directly onto XCR3D fins

7. **Install ADXL345**
   - Mount breakout board to plate top with 2x M2.5x8 screws
   - Route cable along arm toward electronics

8. **Belt Installation**
   - Thread GT2 belt through base channel
   - Clamp both belt ends in clamp slots
   - Tension appropriately (belt should "twang" when plucked)

9. **Final Check**
   - Slide carriage full X-travel on rods
   - Verify no binding, fan clearance, probe clearance
   - Check total weight (target: <163g with hotend)

---

## Firmware Configuration Notes

After physical installation, update firmware (Marlin/Klipper):

```
# Probe offset (measure actual, these are estimates)
X_PROBE_OFFSET = 30    # probe is 30mm to the right of nozzle
Y_PROBE_OFFSET = 0     # probe is inline with nozzle in Y
Z_PROBE_OFFSET = -2.0  # probe triggers ~2mm above bed (calibrate!)

# ADXL345 (for input shaping / resonance compensation)
# Connect via SPI to mainboard
# Run resonance test to determine optimal shaper frequency

# XCR3D 2IN1-S1 specific
# - Two extruder inputs, single nozzle
# - Configure as mixing extruder OR tool-switch in firmware
# - Retraction settings: test 1-3mm retraction for color switch
```

---

## Design Notes

- **Modularity**: Changing hotend only requires reprinting Layer 2 (plate). Layer 1 and 3 stay.
- **Future linear rail**: Only Layer 1 needs redesign for MGN12H carriage mount.
- **Weight budget**: 88g printed + 43g hotend + ~30g hardware = ~161g total (under 163g target)
- **Print orientation**: Base prints flat (rod holes as horizontal cylinders). Plate prints flat (mount face up). Duct prints upright.
- **Post-processing**: Drill bearing bores with 15mm drill bit if needed. Tap M2.5 holes if tight.
