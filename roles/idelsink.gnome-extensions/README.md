# Gnome Extensions

This role handles installing [Gnome Shell extensions](https://extensions.gnome.org/).

## Role variables

- `gnome_extensions_url` - Gnome Extensions URL.
- `gnome_extensions` (default: `[]`) - Gnome extensions to install/uninstall/enable/disable
- `gnome_extensions[].state` (default: `present`) - Install (`present`) or uninstall (`absent`) the extensions.
- `gnome_extensions[].enabled` (default: `true`) - Enable or disable an extension.
- `gnome_extensions[].force` (default: `false`) - Overwrite the existing extension.
- `gnome_extensions[].id` (required) - The extension ID. E.g. `https://extensions.gnome.org/extension/19/user-themes/` Has the ID of `19`. (`https://extensions.gnome.org/extension/<extension ID>/<extension name>/`)
