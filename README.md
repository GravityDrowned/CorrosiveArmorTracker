# Corrosive Armor Tracker

## Description

Corrosive Armor Tracker is an Elder Scrolls Online addon that monitors when opponents activate the Corrosive Armor ultimate ability and provides real-time warnings when you hover over affected enemies.

## Features

- **Real-Time Tracking**: Instantly detects when enemies use Corrosive Armor ultimate (ability ID: 17878)
- **Visual Warnings**: Displays a prominent warning banner when hovering over enemies with active Corrosive Armor
- **Sound Alerts**: Optional audio notification when hovering over affected enemies
- **Customizable**: Toggle visual and sound alerts independently via slash commands
- **Lightweight**: Minimal performance impact with efficient event handling

## Installation

1. Download the addon folder `CorrosiveArmorTracker`
2. Place it in your ESO AddOns folder:
   - **Windows**: `Documents\Elder Scrolls Online\live\AddOns\`
   - **Mac**: `~/Library/Application Support/Elder Scrolls Online/live/AddOns/`
   - **Linux**: `~/.config/Elder Scrolls Online/live/AddOns/`
3. Restart ESO or use `/reloadui` in-game
4. Addon should appear in your Addons menu

## Usage

Once installed and enabled, the addon works automatically:

1. When an enemy uses Corrosive Armor ultimate, the addon begins tracking them
2. Move your crosshair/hover over the affected enemy
3. A bright red warning banner with orange text appears: **⚠ CORROSIVE ARMOR ACTIVE ⚠**
4. The enemy's name is displayed below the warning
5. An optional sound alert plays (configurable)
6. Warning disappears when you stop hovering the tracked enemy

## Configuration

Use slash commands to customize the addon behavior:

| Command | Effect |
|---------|--------|
| `/cat` | Display current settings status |
| `/cat sound` | Toggle sound alerts ON/OFF |
| `/cat visual` | Toggle visual alerts ON/OFF |

Settings are saved per character and persist across play sessions.

## Technical Details

- **Tracked Ability**: Corrosive Armor (ID: 17878)
- **Primary Events**:
  - `EVENT_EFFECT_CHANGED`: Detects when buff is applied or fades
  - `EVENT_RETICLE_TARGET_CHANGED`: Updates display when hovering different targets
- **API Version**: 101043 (ESO Update 44)
- **Saved Variables**: `CorrosiveArmorTrackerSavedVars`

## Troubleshooting

**Warning not appearing?**
- Verify the addon is enabled in your Addons menu
- Use `/reloadui` to reload the interface
- Confirm the enemy is actually using Corrosive Armor (ability ID 17878)
- Check that visual alerts are enabled with `/cat`

**Sound not playing?**
- Ensure sound alerts are enabled with `/cat sound`
- Check your ESO sound settings
- Verify other addons aren't conflicting

**Addon not loading?**
- Confirm all files are in the `CorrosiveArmorTracker` folder
- Verify the `.txt` manifest file is present and correctly named
- Check the ESO error log for detailed error messages
- Use `/reloadui` to reload

## Credits

Inspired by KhalnarsNightmareTracker and other ESO tracking addons. Built with the ESO API.

## Version History

- **v1.0** (Initial Release): Core functionality for tracking Corrosive Armor with visual and sound alerts