#!/bin/sh

NVIM_APP_NAME=nvim
NVIM_APP_CONFIG=~/.config/$NVIM_APP_NAME
export NVIM_APP_NAME NVIM_APP_CONFIG

rm -rf $NVIM_APP_CONFIG && mkdir -p $NVIM_APP_CONFIG

stow --restow --target=$NVIM_APP_CONFIG .
