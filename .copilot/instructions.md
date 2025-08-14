# Copilot Configuration for Spacecraft VMS

## Project Context

This is a spacecraft Vehicle Management System (VMS) with the following components:

- **Firmware**: Real-time C17 code using FreeRTOS for STM32H7 microcontrollers
- **ROS 2**: Python/C++ nodes for high-level autonomy using ROS 2 Humble
- **Simulation**: Basilisk-based spacecraft dynamics simulation
- **Safety-Critical**: MISRA-C compliant code with comprehensive testing

## Coding Guidelines

### C/C++ (Firmware)
- Use C17 standard with MISRA-C:2012 compliance
- 4-space indentation, 100-char line limit
- Prefix functions with module name (e.g., `CCSDS_BuildPrimary()`)
- Use `_t` suffix for type definitions
- Error handling: return codes, not exceptions
- No dynamic allocation after scheduler start

### Python (ROS 2)
- Follow PEP 8 with Black formatting
- Use type hints for all function signatures
- Snake_case for functions/variables, PascalCase for classes
- Comprehensive docstrings with Args/Returns sections

### General Patterns
- Defensive programming with parameter validation
- Comprehensive error handling and logging
- Unit tests for all new functions
- Documentation for all public APIs

## Domain Knowledge

### Spacecraft Systems
- CCSDS space packet protocols for telemetry/commands
- ADCS (Attitude Determination and Control Systems)
- EPS (Electrical Power Systems)
- CDH (Command and Data Handling)
- FDIR (Fault Detection, Isolation, Recovery)

### Real-Time Constraints
- Deterministic execution timing
- Fixed-priority scheduling
- Lock-free data structures preferred
- Interrupt service routine guidelines

### Safety Considerations
- Watchdog timer implementation
- Safing modes for fault conditions
- Redundancy and graceful degradation
- Hazard analysis and mitigation

## Preferred Libraries/Frameworks

- FreeRTOS for real-time kernel
- Unity/CMock for C unit testing
- littlefs for flash file system
- ROS 2 lifecycle nodes for autonomy
- CycloneDDS for ROS 2 middleware

## Testing Philosophy

- Test-driven development preferred
- >90% code coverage requirement
- Hardware-in-the-loop testing for critical paths
- Simulation-based verification
- Static analysis integration (cppcheck, clang-tidy)

When suggesting code, please consider these guidelines and the safety-critical nature of spacecraft systems.
