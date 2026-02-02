# Bash-Scripts
- This is a collection of TUI-based scripts that **do things**.
- All scripts depend on `scripts.lib` & `scripts.cfg`, best practice is to [**download the repository**](https://github.com/Switch123456789/Bash-Scripts/archive/refs/heads/main.zip).
- **Make scripts executable** if needed with: `chmod +x *`.

# ffs.sh (FreeFileSync)
## Modify FFS-config to delete excluded files:
This script assists in deleting excluded files from the right side(s) of a FFS-config. If you're mirroring from left to right and sometimes add exclusions that have been synced before, you potentially end up with unwanted files on the right side that will rot there until eternity unless you delete them manually one by one.

It creates a modified copy of your `.ffs_gui`-file, by pointing the left side to an empty folder and turning all exclusions into inclusions. This creates a scenario in which FFS mirrors "nothing" to all originally excluded files and therefore deleting them on the right side when executing the Synchronization.

### Requirements:
- Make sure **whiptail is installed**.
- Make sure **`FFS_PATH_BIN` is set** in `scripts.cfg`  accordingly.

### Usage:
2. **Start script** with `./ffs.sh "/path/to/config_file.ffs_gui"`, this will open FFS with a modified .ffs_gui file.
5. **Click `Compare`** and all leftover files should show up.
6. **Quadruple-check** if those files can be deleted safely (It works perfectly for me, but I didn't do a whole lot of testing).
7. **Click `Synchronize`** to delete them.
8. If you **close FFS** now, the script will delete the modified config-file again and is done.