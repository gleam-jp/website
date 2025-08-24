# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Gleam web application using the Lustre framework for building client-side web interfaces. The project is configured with a custom Nix flake for development environment setup and uses TailwindCSS for styling.

## Development Environment

The project uses Nix with devenv for development environment management:
- Run `nix develop` or `direnv allow` (if using direnv) to enter the development shell
- The flake provides Gleam 1.11.0, Erlang, TailwindCSS 4, and other development tools
- Python livereload and inotify-tools are available for development workflow

## Common Commands

### Building and Running
- `gleam run` - Run the project (starts the Lustre web application)
- `gleam test` - Run the test suite using gleeunit
- `gleam build` - Build the project
- `gleam format` - Format Gleam code

### Development Workflow
The project outputs built assets to `/priv/static/`:
- `website.mjs` - Compiled JavaScript bundle
- `website.css` - Compiled CSS (includes TailwindCSS)

## Architecture

### Core Structure
- **Entry Point**: `src/website.gleam` - Main application using Lustre's simple architecture
- **Web Framework**: Uses Lustre with the Elm Architecture pattern (init, update, view)
- **Frontend**: Single-page application mounted to `#app` div in `index.html`
- **Styling**: TailwindCSS configured to process files in `src/` and `index.html`

### Lustre Application Pattern
The main application follows Lustre's simple architecture:
```gleam
lustre.simple(init, update, view)
```
- `init/1` - Initialize application state
- `update/2` - Handle messages and update state  
- `view/1` - Render HTML based on current state

### Dependencies
- **lustre** (5.1.1+) - Web framework for building interactive applications
- **gleam_stdlib** - Standard library
- **lustre_dev_tools** (dev) - Development tooling for Lustre
- **gleeunit** (dev) - Testing framework

### Testing
- Tests are in `/test/` directory using gleeunit
- Test functions must end with `_test` suffix
- Run individual tests with `gleam test --target=your_target`

## File Structure Notes

- `/src/website.gleam` - Main application entry point
- `/test/website_test.gleam` - Test suite
- `/priv/static/` - Built assets (CSS/JS)
- `/index.html` - HTML template with app mount point
- `gleam.toml` - Project configuration and dependencies
- `tailwind.config.js` - TailwindCSS configuration