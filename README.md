# Flutter Flavors Demo

## Getting Started

This project uses Flutter Flavors to demonstrate how to build multiple versions of an app from same codebase. It can be built via command line with following commands for the two flavors included:

- flutter run lib/main_simpsons.dart --flavor Simpsons
- flutter run lib/main_thewire.dart --flavor TheWire

In addition, the app uses flutter_bloc for state management and reuses widgets to render master/detail views.  