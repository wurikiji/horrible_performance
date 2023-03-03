#!/bin/sh

# if $1 not entered
if [ -z "$1" ]; then
  echo "Please enter a number"
  exit 1
fi

# if dart exists
if [ -x "$(command -v dart)" ]; then
  echo "===== Dart VM ====="
  dart run src/dart_version.dart $1

  echo "\n===== Dart Compiled ====="
  dart compile exe src/dart_version.dart  -o dart_version &> /dev/null && ./dart_version $1
fi

# if g++ exists
if [ -x "$(command -v g++)" ]; then
  echo "\n===== CPP Compiled with -g -O0 ====="
  g++ --std=c++17 -g -O0 -o cpp_version src/cpp_version.cpp &> /dev/null && ./cpp_version $1

  echo "\n===== CPP Compiled with -O0 ====="
  g++ --std=c++17 -O0 -o cpp_version src/cpp_version.cpp &> /dev/null && ./cpp_version $1

  echo "\n===== CPP Compiled with -O1 ====="
  g++ --std=c++17 -O1 -o cpp_version src/cpp_version.cpp &> /dev/null && ./cpp_version $1

  echo "\n===== CPP Compiled with -O2 ====="
  g++ --std=c++17 -O2 -o cpp_version src/cpp_version.cpp &> /dev/null && ./cpp_version $1

  echo "\n===== CPP Compiled with -O3 ====="
  g++ --std=c++17 -O3 -o cpp_version src/cpp_version.cpp &> /dev/null && ./cpp_version $1

  echo "\n===== CPP Compiled with -Ofast ====="
  g++ --std=c++17 -Ofast -o cpp_version src/cpp_version.cpp &> /dev/null && ./cpp_version $1

fi