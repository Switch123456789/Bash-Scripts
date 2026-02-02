# Bash-Scripts
- This is a collection of scripts that do things. They are TUI-based using "whiptail".
- All scripts depend on `scripts.lib` & `scripts.cfg`, best practice is to download the whole repository.
- Make scripts executable if needed with: `chmod +x *`.
- These scripts should work on most linux-setups, **only `whiptail`** might be something that yyou have to install

# ffs.sh (FreeFileSync)
## Modify config to remove excluded files:
This script assists in deleting excluded files from the right side(s) of a FFS-config. If you're mirroring from left to right and sometimes add exclusions that have been synced before, you potentially end up with unwanted files on the right side that will rot there until eternity unless you remove them manually one by one.

It creates a modified copy of your `.ffs_gui`-file, by pointing the left side to an empty folder and turning all exclusions into inclusions. This creates a scenario in which FFS mirrors "nothing" to all originally excluded files and therefore removing them on the right side when executing the Synchronization.

### Usage:
1. In `scripts.cfg` **set `FFS_PATH_BIN`** accordingly.
2. **Start script** with `./ffs.sh "/path/to/config_file.ffs_gui"`, this will open FFS with a modified .ffs_gui file.
5. **Click `Compare`** and all leftover files should show up.
6. **Quadruple-check** if those files can be removed safely (It works perfectly for me, but I didn't do a whole lot of testing).
7. **Click `Synchronize`** to remove them.
8. If you **close FFS** now, the script will remove the modified config-file again and is done.