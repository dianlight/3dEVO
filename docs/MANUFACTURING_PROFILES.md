# Manufacturing Profiles

## 3D Printing Profiles

### PLA - Structural
| Parameter | Value |
|-----------|-------|
| Layer height | 0.2 mm |
| Nozzle | 0.4 mm |
| Perimeters | 4 |
| Infill | 50% (gyroid) |
| Print speed | 50 mm/s |
| Nozzle temp | 210 C |
| Bed temp | 60 C |
| Supports | Only where required (>50 deg overhang) |
| First layer | 0.3mm, 20 mm/s |

### PLA - Standard
| Parameter | Value |
|-----------|-------|
| Layer height | 0.2 mm |
| Nozzle | 0.4 mm |
| Perimeters | 3 |
| Infill | 20% (grid) |
| Print speed | 60 mm/s |
| Nozzle temp | 205 C |
| Bed temp | 60 C |

### TPU - Flexible Parts
| Parameter | Value |
|-----------|-------|
| Layer height | 0.2 mm |
| Nozzle | 0.4 mm |
| Perimeters | 4 |
| Infill | 30% (gyroid) |
| Print speed | 25 mm/s |
| Nozzle temp | 225 C |
| Bed temp | 50 C |
| Retraction | Minimal (1-2mm, direct drive) or disabled (bowden) |

## CNC Laser Profiles

### Plywood 3mm - Cut
| Parameter | Value |
|-----------|-------|
| Power | 80-100% |
| Speed | 200-300 mm/min |
| Passes | 1-2 |
| Air assist | On |
| Focus | Surface |

### Plywood 5mm - Cut
| Parameter | Value |
|-----------|-------|
| Power | 100% |
| Speed | 100-200 mm/min |
| Passes | 2-3 |
| Air assist | On |
| Focus | Surface or mid-material |

### Engraving (Wood)
| Parameter | Value |
|-----------|-------|
| Power | 20-40% |
| Speed | 1000-2000 mm/min |
| Passes | 1 |
| Mode | Line/fill |

## CNC Spindle Profiles

### Wood - Pocket/Profile
| Parameter | Value |
|-----------|-------|
| Tool | 3.175mm flat end mill |
| Spindle speed | 10000-12000 RPM |
| Feed rate | 800-1200 mm/min |
| Depth per pass | 1-2 mm |
| Step-over | 40% tool diameter |

### Acrylic - Cut
| Parameter | Value |
|-----------|-------|
| Tool | Single flute 3.175mm |
| Spindle speed | 12000 RPM |
| Feed rate | 500-800 mm/min |
| Depth per pass | 0.5-1 mm |
| Coolant | Compressed air |

---

**Note**: All profiles are starting points. Test on scrap material before production cuts. Adjust based on actual machine calibration and material batch variations.
