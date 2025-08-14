# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Project structure modernization with src/ layout
- Comprehensive GitHub Actions CI/CD workflows
- VSCode development environment configuration
- Static analysis integration (cppcheck, clang-tidy)
- Code coverage reporting setup
- Unity/CMock/Ceedling testing framework preparation
- Docker and DevContainer support structure
- Security policy and vulnerability reporting process
- Comprehensive documentation templates

### Changed
- Migrated to modern project structure with src/ organization
- Updated build system to support both Make and Ninja generators
- Enhanced VS Code settings with strict coding standards
- Improved .gitignore for better artifact exclusion

### Deprecated
- Legacy direct folder structure (firmware/, docs/ at root)

### Security
- Added security scanning with CodeQL and Trivy
- Implemented secure development guidelines
- Added CODEOWNERS for critical component review

## [0.1.0] - 2025-08-13

### Added
- Initial project scaffold for Spacecraft VMS
- POSIX/SIL firmware build system with CMake
- CCSDS space packet primary header implementation
- Lock-free SPSC pub/sub ring buffer system
- Basic logging and watchdog stub implementations
- Unit tests for CCSDS and pub/sub components
- FreeRTOS task structure placeholder
- Documentation templates for architecture, safety, interfaces

### Technical Details
- C17 standard with strict compiler warnings
- CMake 3.23+ build system
- CTest integration for unit testing
- POSIX threading for SIL environment
- Modular library architecture (vms_core)

### Testing
- 3 unit tests implemented (CCSDS, pub/sub, smoke test)
- 100% test pass rate
- Build validation on Ubuntu 22.04 with GCC 13

### Dependencies
- CMake 3.23+
- GCC 13+ or compatible C17 compiler
- POSIX-compliant system for SIL builds
- pthreads and math libraries
