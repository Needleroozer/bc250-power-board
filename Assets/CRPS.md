## CRPS

The rack-mount BC-250 chassis includes a pair of Great Wall 1200W `GW-CRPS1200D2` 1U power supplies. It turns out that, as the part number implies, these correspond with the CRPS (Common Redundant Power Supply) spec. As 73.5mm wide supplies, they implement the 50-pin (36 power + 14 data) version of the spec, which includes 12V standby power, an active-low `PS_ON#` output, and a PMBUS interface.

### Sizing/Substitutes
The metal enclosures on these are 185mm long, which is very convenient for making a BC-250 case.

However, if you want to get a replacement or don't have a rack chassis to pillage, you'll need to find something else. The Supermicro `PWS-1K02A-1R` is an exceedingly common 1000W 1U supply that looks very much like it implements the CRPS pinout, but it's 203mm long according to its offical specification page. This causes the clearance to get a little tight, but I think it should be manageable...

## Connector 
As far as I can tell, the cheapest available connector that is explicitly designed for CRPS is the Amphenol `HPG36P14SRT051T-02`.

However, any 2.54mm pitch card-edge receptacle that accepts a 1.6mm card-edge should work...

### The case of the missing WingTAT design files

I would have bought one of the Amphenol connectors in my latest Digikey order but I managed to forget to grab one while replenishing my stock of capacitors. However, I think that using a generic connector might allow for a more dense configuration...

I found something that looks very much like a WingTAT `ER50BGFBK` connector on Aliexpress, but I couldn't find a 3D model. However, googling around for 3D models revealed a model of an 86-pin variant that looked shockingly similar despite going by the part number `S-86L-2.54-5`.

Because I have an OpenSCAD hammer, everything looks like a nail. So I imported it into OpenSCAD, translated it over by 18 pins' worth of space, mirrored it, and then exported the resulting "solid" so that I could use it in KiCAD.

Searching for `S-50L-2.54-5` revealed the existence of a schematic symbol and footprint file on EasyEDA, so I used `easyeda2kicad` to pull the footprint down.

```bash
% pip install easyeda2kicad
% easyeda2kicad --footprint --lcsc_id=C9900023330
-- easyeda2kicad.py v0.8.0 --
...
[INFO] Created Kicad footprint for ID: C9900023330
       Footprint name: CONN-TH_50P-P2.54_S-50L-2.54-5
       Footprint path: easyeda2kicad.pretty/CONN-TH_50P-P2.54_S-50L-2.54-5.kicad_mod
```

Alright, now we have a footprint and a 3D model.
