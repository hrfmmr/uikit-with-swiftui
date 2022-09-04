#!/bin/bash

# Fail whole script when any step fails
set -e

# Install [Mint](https://github.com/yonaskolb/Mint) if needed
type mint > /dev/null || brew install mint

# Install [needle](https://github.com/uber/needle) if needed
type needle > /dev/null || brew install needle

# Install dependencies via mint
mint bootstrap
