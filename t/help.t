#!/usr/bin/env bash

# Copyright © 2021-2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
pdir="${0%/*}/.."
prog="$pdir/mooflon"
echo 1..1
xout=$(< "$pdir/README")
xout=${xout#*$'\n   $ mooflon --help\n   '}
xout=${xout%%$'\n\n'[! ]*}
xout=${xout//$'\n   '/$'\n'}
export COLUMNS=100
out=$("$prog" --help)
if [ "$out" = "$xout" ]
then
    echo ok 1
else
    diff -u <(cat <<< "$xout") <(cat <<< "$out") | sed -e 's/^/# /'
    echo not ok 1
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
