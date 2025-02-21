#!/bin/bash

cmake -B build -S .
cmake --build build
cmake --install build
