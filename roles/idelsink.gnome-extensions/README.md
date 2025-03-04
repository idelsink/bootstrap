# Gnome Extensions

This role handles installing [Gnome Shell extensions](https://extensions.gnome.org/).
This uses the dbus API where the installation requires a confirmation of the user in the Gnome Shell.

When installing gnome extensions using the gnome-extensions cli (`gnome-extensions install ...`) we need to register this app to Gnome or restart the gnome session in order for it to pick up this change.

It was possible to use a dbus Eval method (see example below) to load this, but due to security related changes, this is not as simple anymore. So to make it simpler, we just require the user to approve of the install of the extension.

See also:

- [Enable Gnome Extensions without session restart](https://discourse.gnome.org/t/enable-gnome-extensions-without-session-restart/7936)
- [Installing gnome-shell extensions on command line?](https://old.reddit.com/r/gnome/comments/rbl85n/installing_gnomeshell_extensions_on_command_line/)
- [GNOME Shell Extension Install possible without Restart?](https://stackoverflow.com/questions/62265594/gnome-shell-extension-install-possible-without-restart)
- [Command line tool to install GNOME Shell extensions](https://unix.stackexchange.com/questions/617288/command-line-tool-to-install-gnome-shell-extensions)
- Example of script that can be executed to reload the extensions [gnome-47-load-new-extensions.js](https://gist.github.com/piousdeer/1899b0b06a143af787528f4624ba3f0f)
- Example of small snippit that can be executed to reload a extension.This throws an error with uncaught referenceError ExtensionUtils not defined. `ExtensionUtils.ExtensionType.PER_USER` is defined as `2` and can be replaced by that for testing purposes.
    ```js
    // Example of loading in a newly installed extension
    const uuid = "<extension UUID>";
    const dir = Gio.File.new_for_path(GLib.build_filenamev([global.userdatadir, 'extensions', uuid]));
    const extension = Main.extensionManager.createExtensionObject(uuid, dir, ExtensionUtils.ExtensionType.PER_USER);
    Main.extensionManager.loadExtension(extension);
    ```

Realistcally, this will be run on the target system where we have access to the

https://discourse.gnome.org/t/enable-gnome-extensions-without-session-restart/7936/9
https://gist.github.com/piousdeer/1899b0b06a143af787528f4624ba3f0f

## Role variables

- `gnome_extensions_url` - Gnome Extensions URL.
- `gnome_extensions` (default: `[]`) - Gnome extensions to install/uninstall/enable/disable
- `gnome_extensions[].state` (default: `present`) - Install (`present`) or uninstall (`absent`) the extensions.
- `gnome_extensions[].enabled` (default: `true`) - Enable or disable an extension.
- `gnome_extensions[].force` (default: `false`) - Overwrite the existing extension.
- `gnome_extensions[].id` (required) - The extension ID. E.g. `https://extensions.gnome.org/extension/19/user-themes/` Has the ID of `19`. (`https://extensions.gnome.org/extension/<extension ID>/<extension name>/`)
