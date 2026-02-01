# Bash-Scripts
### About:
A collection of scripts that do things. They are TUI-based using "whiptail".
### Infos:
Make scripts executable if needed with: `chmod +x *`.  I assume these scripts should work on most linux-setups, **only `whiptail`** might be something that is not yet installed on your system.

# ffs.sh (FreeFileSync)
## Create modified config to remove excluded files:
This is meant for easy removal of files that were not deleted on the right side before excluding them in FFS (When mirroring from left to right). They can be hard to spot if a lot of changes have been made to the exclusion list. This also works with multiple pairs and separate pair-settings.

### Usage:
1. In `scripts.cfg` **set `FFS_PATH_BIN`** accordingly.
2. **Start script** with `./ffs.sh "/path/to/config_file.ffs_gui"`, this will open FFS with a modified .ffs_gui file.
5. **Click `Compare`** and all leftover files should show up.
6. **Quadruple-check** if those files can be removed safely (It works perfectly for me, but I didn't do a whole lot of testing).
7. **Click `Synchronize`** to remove them.
8. If you **close FFS** now, the script will remove the modified config-file again and is done.

### How does it work:
It creates a modified version of the source-.ffs_gui-file, by replacing the left side with an empty folder and setting all exclusions to be inclusions. This creates a scenario in which FFS mirrors "nothing" to all originally excluded files and therefore removing them on the right side when executing the Synchronization.