# 3dEVO - Available Materials BOM

> This is the **preferred picking list**. All design decisions should prioritize components from this inventory.  
> Parts not available or adaptable from this BOM must be flagged as **"To Buy"** in the final assembly BOM.

---

## 1. Filament & Adhesives

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 1.1 | PLA 1.75mm - Black | 0.7 kg | FDM printing, structural parts |
| 1.2 | PLA 1.75mm - White | 0.7 kg | FDM printing, visual/secondary parts |
| 1.3 | Super Glue 502 (Cyanoacrylate) | 1 | Instant bonding, small parts |
| 1.4 | Epoxy AB | 1 set | Structural bonding, high-strength joints |
| 1.5 | 3D Printer Grease | 1 | Linear rail/bearing lubrication |

---

## 2. Mechanical - Linear Motion

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 2.1 | LMK8UU (8mm flanged linear bearing) | - | Flanged mount, 8mm shaft |
| 2.2 | LMK6UU (6mm flanged linear bearing) | - | Flanged mount, 6mm shaft |
| 2.3 | RJ4JP-01-08 (8mm polymer linear bearing) | 2 | Dry-run, low noise, 8mm shaft |
| 2.4 | RJMP-01-10 (10mm polymer linear bearing) | 4 | Dry-run, low noise, 10mm shaft |
| 2.5 | Lead Screw 2mm pitch, 350mm length | 1 | Linear actuation, Z-axis or similar |

---

## 3. Mechanical - Bearings

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 3.1 | 608ZZ (8x22x7mm) | - | Standard skateboard bearing |
| 3.2 | 688ZZ (8x16x5mm) | - | Miniature bearing, compact joints |

---

## 4. Mechanical - Belts & Pulleys

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 4.1 | GT2 Closed Loop Belt - 110mm | 1 | Short loop, compact drive |
| 4.2 | GT2 Closed Loop Belt - 610mm | 1 | Medium loop |
| 4.3 | GT2 Closed Loop Belt - 690mm | 1 | Long loop, axis drive |
| 4.4 | GT2 Pulley 20T, bore 4mm, width 6mm | - | Small shaft drive |
| 4.5 | GT2 Pulley 20T, bore 8mm, width 10mm | - | Larger shaft drive |

---

## 5. Mechanical - Fasteners & Inserts

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 5.1 | M1.4 x 12mm screws | kit | Micro fastening |
| 5.2 | M1.6 x 12mm screws | kit | Micro fastening |
| 5.3 | M2 Mix Kit (screws, nuts, washers) | 1 kit | Small assemblies |
| 5.4 | M2.5 Mix Kit (screws, nuts, washers) | 1 kit | Electronics mounting |
| 5.5 | M3 Brass Heat-Set Inserts | pack | Threaded connections in PLA |
| 5.6 | N52 Neodymium Magnet 10x5x2mm | - | Strong rectangular magnets |
| 5.7 | N50 Neodymium Magnet D2x2mm | - | Small cylindrical magnets |

---

## 6. Mechanical - Structural

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 6.1 | 2020 Aluminium Extrusion Corner Brackets | - | Frame joints, 90-degree connections |
| 6.2 | PTFE Tube (Teflon, 1.75mm filament path) | - | Low-friction filament guide |

---

## 7. Motors & Actuators

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 7.1 | NEMA 17 17HS08 (low profile) | - | Compact stepper, reduced height |
| 7.2 | NEMA 17 Damper (stepper vibration mount) | - | Noise/vibration reduction |
| 7.3 | TZT JF.0530B 6V Solenoid | - | Push/pull actuator, 6V DC |

---

## 8. Extrusion & Hotend

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 8.1 | 3D Titan Extruder | 3 | Geared extruder, 1.75mm filament |
| 8.2 | 3D Titan Aero Heat Sink | 1 | Cooling for Titan Aero assembly |
| 8.3 | 3DSWAY E3D Hotend Pneumatic Connectors | - | Quick-connect filament fittings (PC4-M6/M10) |
| 8.4 | LOOLIFL Blue (PTFE throat/liner) | 1 | Hotend throat lining |
| 8.5 | Varon Nozzle Cleaning Brush Kit | 1 | Maintenance tooling |

---

## 9. Electronics - Sensors & Modules

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 9.1 | BIGTREETECH Eddy Duo | 1 | Eddy current bed probe (inductive, high precision) |
| 9.2 | AS5600 Magnetic Encoder | - | 12-bit rotary position sensor, I2C |
| 9.3 | MCP2515 CAN Bus Receiver Module | - | SPI-to-CAN interface |
| 9.4 | Break Detection Module (Ender 3/CR10 type) | 2 | Filament runout sensor, 1m cable |

---

## 10. Electronics - Connectors & Wiring

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 10.1 | GX16 5-Pin Connector (full set, male+female) | - | Panel-mount circular connector |
| 10.2 | GX16 Female with 1.5m 5-Pin cable | - | Pre-wired harness |
| 10.3 | 12 AWG Wire (Red + Black) | - | High-current power lines |
| 10.4 | 24 AWG DB9 9-Pin Cable | - | Signal/communication cable |

---

## 11. Electronics - Cooling

| # | Item | Qty | Notes |
|---|------|-----|-------|
| 11.1 | Fan 30x30x10mm 12V 2-pin | - | Part cooling / hotend |
| 11.2 | Fan 30x30x10mm 12V 3-pin (tachometer) | - | Monitored cooling |
| 11.3 | Fan 30x30x10mm 5V 2-pin | - | Electronics/board cooling |

---

## Design Priority Rules

1. **Use available stock first** — adapt the design to fit what we have
2. **Parametric flexibility** — design around available bearing sizes (6mm, 8mm, 10mm shafts)
3. **Motor standardization** — all motion uses NEMA 17 (low-profile where space is tight)
4. **Belt-driven preferred** — GT2 system already available in 3 loop sizes
5. **Connector standard** — GX16 for external connections, keep internal wiring short
6. **Sensor integration** — AS5600 for rotary feedback, Eddy Duo for Z-probe, break detection for filament path
7. **Multi-material ready** — 3 Titan extruders available suggests multi-filament or tool-change capability

---

## Notes

- Quantities marked with `-` indicate "available but exact count not confirmed" — verify before committing to design
- The 3 Titan Extruders + break detection modules + multiple belt loops suggest a **multi-extruder or tool-changing** architecture
- GT2 belt lengths (110mm, 610mm, 690mm) will constrain axis center distances — design around these
- Lead screw 350mm defines max Z-travel (minus nut height and end clearances)
