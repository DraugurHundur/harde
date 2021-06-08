#! /usr/bin/env bash
# -*- mode: shell; coding: utf-8-unix -*-

# This function ensures access is minimal
# i.e no grant for group or other rather than checking for an exact match
function check_perm(){
    # $1 is required mode REQ
    # e.g. 0640 
    # if the file is 0620 the check is successful
    # but of it is 0622 it is not, so simple comparison does not work
    # split REQ and PERM in four and compare each number
    [ $# -ge 2 ] || return 2
    local REQ="$1"
    local FAILED=0
    shift
    local f
    local FF
    for f in "$@"; do
	    local PERM
      PERM="$(stat --printf %04a "${f}")"
      # ignore non-existent files
      [ $? -eq 1 ] && return 0
      local r
      local p
      for i in 1 2 3 4; do
        r=$(echo "$REQ" | cut -c$i)
        p=$(echo "$PERM" | cut -c$i)
        if [ "$p" -gt "$r" ]; then
          FF="$FF\n$f\n"
          FAILED=1
          break
        fi 
      done
    done
  [ $FAILED -eq 1 ] && echo -e "$FF" | batslib_decorate "Wrong permissions" | fail
  return 0
}

function check_perm_from_file(){
  local PERM
  [ $# -ge 2 ] || return 2
  PERM="$(stat --printf %04a $1)"
  # exit on non-existent file
  [ $? -eq 1 ] && return 2
  check_perm "${PERM}" "$2"
}

function check_owner(){
    [ $# -ge 2 ] || return 2
    local REQ=$1
    shift
    local f
    local FF
    local FAILED=0
    for f in "$@"; do
	    local OWNER
      OWNER="$(stat --printf %U "${f}")"
	    if [ "${OWNER}" != "${REQ}" ]; then
	      FF="$FF\n$f\n"
        FAILED=1
        break
	    fi
    done
  [ $FAILED -eq 1 ] && echo -e "$FF" | batslib_decorate "Wrong owner" | fail
  return 0
}

function check_group(){
  [ $# -ge 2 ] || return 2
  local REQ=$1
  shift
  local f
  local FF
  local FAILED=0
  for f in "$@"; do
	  local GROUP
    GROUP="$(stat --printf %G "${f}")"
	  if [ "${GROUP}" != "${REQ}" ]; then
	    FF="$FF\n$f\n"
      FAILED=1
      break
	  fi
  done
  [ $FAILED -eq 1 ] && echo -e "$FF" | batslib_decorate "Wrong group" | fail
  return 0
}

function is_a_partition(){
  [ $# -ge 1 ] || return 32
  local DEV
  local DEVPARENT
  local d
  for d in "$@"; do
    # the mount point does not exist or is not in /etc/fstab exit code 2
	  [ -d "${d}" ] || grep -E -q "$1\\s+" /etc/fstab || return 2
	  if [ "${d}" != "/" ]; then
	    DEV="$(stat --printf %D "${d}")" 2>/dev/null
	    DEVPARENT=$(stat --printf %D "${d}/..") 2>/dev/null
	    if [ "${DEV}" = "${DEVPARENT}" ]; then
        # does not look like a partition so far, maybe it is not mounted
        # fail if not found
        grep -E -q "$1\\s+" /etc/fstab 
	    fi
	  fi
  done
}

function fail_if_output() {
  # read standard input and fails if not empty
  local STDINPUT
  STDINPUT="$(cat -)"
  local ERR
  ERR="${1:-Unexpected output}"
  if [ -n "$STDINPUT" ]; then
    echo "$STDINPUT" \
      | batslib_decorate "$ERR" \
      | fail
  fi
}

# # Theses files are public domain
# # and were downloaded from https://github.com/bats-core/bats-support/blob/master/src
# # shellcheck source=audit/error.bash
# source audit/error.bash
# # shellcheck source=audit/lang.bash
# source audit/lang.bash
# # shellcheck source=audit/output.bash
# source audit/output.bash
