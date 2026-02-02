#!/bin/bash
	source "$(pwd)/scripts.lib" || exit
	SCRIPT_NAME="FreeFileSync"
	SCRIPT_JOB="Launch with modified config"
	if [[ -z "${FFS_PATH_BIN:-}" ]]; then tui_info "FFS_PATH_BIN missing in ffs.cfg"; exit; fi

#[CREATE MODIFIED CONFIG]
	# Create an empty folder that can be mirrored to the destination
	rm -rf "${SCRIPT_PATH:?}/.tmp/*"; mkdir -p "${SCRIPT_PATH}/.tmp/null"; cd "${SCRIPT_PATH}/.tmp" || exit 1
	SKIP=false
	# Iterate through input file
	{ while IFS= read -r LINE; do
		# SKIPPING LINES START
		case "${LINE//$'\r'/}" in (*"<Include>"|*"<Synchronize>")
				SKIP=true
		;;
		# SKIPPING LINES STOP
		(*"</Include>"|"            </Synchronize>")
				SKIP=false
		;;
		# GLOBAL: INJECT SYNC CONFIG
		("    </Synchronize>")
				SKIP=false
				printf '%s\n' \
				'    <Synchronize>' \
				'        <Differences LeftOnly="right" LeftNewer="right" RightNewer="right" RightOnly="right"/>' \
				'        <DeletionPolicy>Permanent</DeletionPolicy>' \
				'        <VersioningFolder Style="Replace"/>' \
				'    </Synchronize>'
		;;
		# GLOBAL: INJECT LEFT PATH 
		("            <Left>"*"</Left>")
				printf '%s\n' "            <Left>${SCRIPT_PATH}/.tmp/null</Left>"
		;;
		# GLOBAL: REVERSE FILTER
		("        <Exclude>")
				printf '%s\n' '        <Include>' '<Item>*</Item>'
		;;
		("        </Exclude>")
				printf '%s\n' '        </Include>' '        <Exclude/>'
		;;
		("        <Exclude/>")
				printf '%s\n' '        <Include/>' '        <Exclude/>'
		;;
		# PAIR: REVERSE FILTER
		("                <Exclude>")
				printf '%s\n' '                <Include>'
		;;
		("                </Exclude>")
				printf '%s\n' '                </Include>' '                <Exclude/>'
		;;
		("                <Exclude/>")
				printf '%s\n' '                <Include/>' '                <Exclude/>'
		;;
		# PASS-THROUGH
		(*)
			if [ "${SKIP}" = false ]; then
						printf '%s\n' "$LINE"
			fi
		;; esac
	done < "${1}"; } > "${SCRIPT_PATH}/.tmp/TEMPORARY-CONFIG.ffs_gui";
		
#[OPEN CONFIG WITH FFS & CLEANUP AFTER CLOSING IT]
	thread() { ${FFS_PATH_BIN} "${SCRIPT_PATH}/.tmp/TEMPORARY-CONFIG.ffs_gui" -Edit; }
	thread_single "Launching FreeFileSync"
	rm -rf "${SCRIPT_PATH}/.tmp"
	tui_info_results