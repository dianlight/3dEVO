# 3dEVO - Baseline Dimensions (Prusa i3 Wooden Frame Clone)

> Reference: [RepRap Prusa i3](https://reprap.org/wiki/Prusa_i3), Rework variant BOM  
> Source: eBay IT listing (Chinese clone, wooden frame, similar to typical i3 kits)

---

## Build Volume

| Axis | Travel | Notes |
|------|--------|-------|
| X | 200 mm | Belt-driven, hotend carriage |
| Y | 200 mm | Belt-driven, bed moves |
| Z | 200 mm | Leadscrew-driven (2x coupled) |

---

## Smooth Rods (8mm diameter, hardened steel)

| Axis | Length | Qty | Function |
|------|--------|-----|----------|
| X | 370 mm | 2 | Hotend carriage rails |
| Y | 350 mm | 2 | Bed carriage rails |
| Z | 320 mm | 2 | Vertical guide rails |

---

## Z-Axis Drive

| Parameter | Typical Clone Value | Notes |
|-----------|-------------------|-------|
| Type | M5 threaded rod OR T8 leadscrew | Clones vary; threaded rod = worse |
| Length | 300 mm | Matches Z rod usable travel |
| Pitch | 0.8mm (M5) or 2mm (T8) | T8 lead screw is preferred upgrade |
| Coupling | Rigid or flexible 5mm-to-5mm | Flexible recommended |
| Motors | 2x NEMA 17, coupled to single driver | Parallel wiring |

**Upgrade note**: Available Lead Screw 2mm pitch x 350mm replaces the stock Z drive directly. Provides ~300mm usable Z-travel (minus nut + coupler clearances).

---

## Y-Axis (Bed)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Rods | 2x 8mm x 350mm | Supported at both ends by frame |
| Rod spacing | ~170 mm (center-to-center) | Verify on actual machine |
| Bearings | 3x or 4x LM8UU | Mounted under bed plate |
| Drive | GT2 belt, ~700-750mm loop | Motor at rear of frame |
| Pulley | GT2 20T on motor, idler at front | |
| Bed plate | Aluminum 200x200mm or 214x214mm | PCB heater glued underneath |
| Bed support | Laser-cut plywood Y-carriage plate | ~200x240mm |

**Upgrade note**: Available GT2 690mm closed loop belt fits Y-axis. RJMP-01-10 (10mm) bearings won't fit directly — use RJ4JP-01-08 (8mm) on existing rods.

---

## X-Axis (Hotend Carriage)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Rods | 2x 8mm x 370mm | Held by Z-carriage brackets |
| Rod spacing | ~45 mm (center-to-center) | Compact, vertical stack |
| Bearings | 3x or 4x LM8UU | In X-carriage printed part |
| Drive | GT2 belt, ~600-650mm loop | Motor on one Z-bracket |
| Pulley | GT2 20T on motor, idler on other bracket | |
| Carriage | Printed part, holds hotend + fan | Moving mass target: <300g |

**Upgrade note**: Available GT2 610mm closed loop belt fits X-axis. RJ4JP-01-08 replaces LM8UU for quieter operation.

---

## Frame (Wooden Clone)

| Parameter | Value | Notes |
|-----------|-------|-------|
| Material | Plywood or MDF, 5-6mm | Laser-cut panels |
| Main plate | Single vertical sheet ~380 x 340mm | Holds Z-axis assembly |
| Y-frame | Box/table structure ~400 x 340 x ~60mm | 4x M10 threaded rods + printed corners |
| M10 threaded rods (short) | 4x 210 mm | Y-frame cross members |
| M10 threaded rods (long) | 2x 380 mm | Y-frame longitudinal rails |
| Connection | Y-frame bolts to vertical plate base | Right-angle joint, weakest point |

### Frame Overall Envelope (approximate)
```
Width (X direction):  ~400 mm
Depth (Y direction):  ~400 mm  
Height (Z direction): ~380 mm (to top of Z rods)
```

---

## Electronics (Typical Clone)

| Component | Typical | Notes |
|-----------|---------|-------|
| Board | MKS Gen L / RAMPS 1.4 / GT2560 | 8-bit ATmega2560-based |
| Drivers | A4988 or DRV8825 | Replaceable modules |
| Display | 12864 LCD + rotary encoder | SD card slot |
| PSU | 12V 20A or 24V 15A | Verify before upgrading hotend |
| Firmware | Marlin 1.x | Outdated but functional |
| Connectivity | USB (serial) + SD card | No WiFi/network |

---

## Hotend & Extruder (Typical Clone)

| Component | Typical | Notes |
|-----------|---------|-------|
| Hotend | E3D V6 clone (all-metal or PTFE-lined) | 12V or 24V heater |
| Nozzle | 0.4mm brass, M6 thread | Standard E3D compatible |
| Thermistor | NTC 100K (ATC Semitec 104GT or generic) | |
| Extruder | MK8 direct drive or basic geared | Weak grip, prone to grinding |
| Filament | 1.75mm | |
| Cooling | 40mm axial fan on heatsink | Often inadequate part cooling |

---

## Key Dimensions for Design Reference

```
                    ┌─── 370mm (X rods) ───┐
                    │                       │
    ┌───────────────┼───────────────────────┼───────────────┐
    │               │   ◄── 200mm X travel ──►              │
    │   Z-bracket   │                       │   Z-bracket   │
    │   ┌───┐       │                       │   ┌───┐       │
    │   │   │  320mm Z rods                 │   │   │       │
    │   │   │  (200mm Z travel)             │   │   │       │
    │   │   │       │                       │   │   │       │
    │   └───┘       │                       │   └───┘       │
    │               │                       │               │
    └───────────────┼───────────────────────┼───────────────┘
                    │      FRAME PLATE      │
                    │    (~380 x 340mm)     │
                    │                       │
    ════════════════╪═══════════════════════╪════════════════
    ║               ║   Y-FRAME TABLE       ║               ║
    ║   ◄─────────── 350mm Y rods ──────────────►           ║
    ║               ║   (200mm Y travel)    ║               ║
    ════════════════╪═══════════════════════╪════════════════
                    │                       │
                    └───── ~400mm depth ────┘
```

---

## Measurements to Verify on Actual Machine

Before designing upgrades, physically measure and record:

- [ ] Frame plate exact dimensions (W x H x thickness)
- [ ] Y-frame rod lengths (M10 threaded, both short and long)
- [ ] Y-rod center-to-center spacing
- [ ] X-rod center-to-center spacing  
- [ ] Z-rod center-to-center spacing (distance between Z towers)
- [ ] Z-rod to leadscrew offset
- [ ] Bed plate dimensions and mounting hole pattern
- [ ] PSU voltage (12V or 24V)
- [ ] Stepper motor shaft diameter (5mm typical)
- [ ] Current hotend type and heater voltage
- [ ] Board model and available ports/drivers
