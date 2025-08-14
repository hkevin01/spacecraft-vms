# Spacecraft Vehicle Management System (VMS)

[![Firmware CI](https://github.com/hkevin01/spacecraft-vms/workflows/Firmware%20CI/badge.svg)](https://github.com/hkevin01/spacecraft-vms/actions/workflows/firmware.yml)
[![ROS 2 CI](https://github.com/hkevin01/spacecraft-vms/workflows/ROS%202%20CI/badge.svg)](https://github.com/hkevin01/spacecraft-vms/actions/workflows/ros2.yml)
[![Static Analysis](https://github.com/hkevin01/spacecraft-vms/workflows/Static%20Analysis/badge.svg)](https://github.com/hkevin01/spacecraft-vms/actions/workflows/static-analysis.yml)

Production-ready spacecraft Vehicle Management System spanning real-time firmware (FreeRTOS), ROS 2 autonomy, and high-fidelity simulation. Designed for mission-critical applications with comprehensive safety analysis and MISRA-C compliance.

## 🚀 Features

### Real-Time Firmware
- **FreeRTOS-based**: LTS kernel with POSIX/SIL testing capability
- **STM32H7 Target**: Production-ready for space-qualified microcontrollers
- **CCSDS Protocols**: Space packet implementation for telemetry/commands
- **Safety-Critical**: MISRA-C:2012 compliant with comprehensive FDIR
- **Secure Boot**: MCUboot integration for trusted firmware updates

### High-Level Computing
- **ROS 2 Humble**: Lifecycle nodes for autonomous mission management
- **State Estimation**: Advanced filtering for attitude and orbit determination
- **Mission Planning**: Automated task execution and contingency handling
- **Ground Communications**: CCSDS file delivery protocol (CFDP) support

### Simulation & Testing
- **Basilisk Integration**: High-fidelity spacecraft dynamics simulation
- **Hardware-in-Loop**: Real-time validation with actual flight hardware
- **Comprehensive Testing**: >90% code coverage with Unity/CMock framework
- **Static Analysis**: Integrated cppcheck, clang-tidy, and security scanning

## 📁 Project Structure

```
spacecraft-vms/
├── src/                          # Source code
│   ├── firmware/                 # Real-time flight software
│   │   ├── app/                  # Application layer
│   │   ├── middleware/           # CCSDS, pub/sub, logging
│   │   ├── safety/               # Watchdog, FDIR systems
│   │   ├── bsp/                  # Board support packages
│   │   └── tests/                # Unit and integration tests
│   ├── ros2_ws/                  # ROS 2 workspace
│   └── simulation/               # Basilisk scenarios
├── scripts/                      # Build and utility scripts
├── tests/                        # System-level tests
├── docs/                         # Documentation
├── data/                         # Configuration and datasets
├── assets/                       # Media and resources
├── .github/                      # CI/CD workflows
├── .vscode/                      # Development environment
└── .copilot/                     # AI assistant configuration
```

## 🛠️ Quick Start

### Prerequisites

- **Ubuntu 22.04 LTS** (recommended)
- **CMake 3.23+**
- **GCC 13+** or Clang 15+
- **ROS 2 Humble** (for autonomy components)
- **Git** with LFS support

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/hkevin01/spacecraft-vms.git
   cd spacecraft-vms
   ```

2. **Install dependencies** (Ubuntu)
   ```bash
   sudo apt update
   sudo apt install build-essential cmake ninja-build gcovr lcov cppcheck clang-tidy
   ```

3. **Install ROS 2 Humble** (optional, for high-level components)
   ```bash
   sudo apt install ros-humble-desktop
   source /opt/ros/humble/setup.bash
   ```

### Building

#### Firmware Only
```bash
# Build and test firmware
./scripts/build.sh --firmware-only --test

# Or manually:
cd src/firmware
cmake -B build -DBUILD_POSIX=ON -DCMAKE_BUILD_TYPE=Release
cmake --build build
ctest --test-dir build --output-on-failure
```

#### Complete System
```bash
# Build everything
./scripts/build.sh --test

# Run comprehensive tests
./scripts/test.sh --all
```

### Development

#### VS Code Setup
The project includes comprehensive VS Code configuration:
- IntelliSense for C/C++ and Python
- Integrated build tasks and debugging
- Code formatting and linting
- GitHub Copilot optimization

#### Git Hooks
```bash
# Install pre-commit hooks
pip install pre-commit
pre-commit install
```

## 🧪 Testing

### Unit Tests
```bash
# Firmware unit tests
cd src/firmware && ctest --test-dir build

# ROS 2 component tests
cd src/ros2_ws && colcon test
```

### Coverage Analysis
```bash
# Generate coverage report
./scripts/test.sh --static
# View: src/firmware/build/coverage.html
```

### Static Analysis
```bash
# Run all static analysis tools
./scripts/test.sh --static
```

## 🔧 Development Workflow

### Coding Standards
- **C/C++**: C17 with MISRA-C:2012 guidelines
- **Python**: PEP 8 with type hints
- **Documentation**: Comprehensive inline and external docs
- **Testing**: TDD with >90% coverage requirement

### Branch Strategy
- `main`: Production-ready releases
- `develop`: Integration branch
- `feature/*`: New feature development
- `bugfix/*`: Bug fixes
- `hotfix/*`: Critical production fixes

### Pull Request Process
1. Create feature branch from `develop`
2. Implement changes with tests
3. Run full test suite locally
4. Submit PR with comprehensive description
5. Code review and CI validation
6. Merge to `develop`

## 🚀 Deployment

### Docker Containers
```bash
# Build development container
docker build -t spacecraft-vms:dev .

# Run with volume mounting
docker run -v $(pwd):/workspace spacecraft-vms:dev
```

### Hardware Deployment
1. Flash bootloader via SWD/JTAG
2. Deploy signed firmware via secure boot
3. Validate system integrity
4. Enable autonomous operations

## 📖 Documentation

### Core Documentation
- [Architecture Overview](docs/architecture.md)
- [Safety Case](docs/safety_case.md)
- [Interface Specifications](docs/interfaces.md)
- [Test Plan](docs/test_plan.md)
- [Project Plan](docs/project_plan.md)

### API Documentation
- Firmware APIs: Generated via Doxygen
- ROS 2 Interfaces: Standard ROS documentation
- Python APIs: Sphinx-generated documentation

## 🔒 Security

This project implements multiple security layers:
- **Secure Boot**: Cryptographic firmware validation
- **Code Signing**: Authenticated software updates
- **Static Analysis**: Automated vulnerability detection
- **Access Control**: Role-based permissions

Report security vulnerabilities via our [Security Policy](.github/SECURITY.md).

## 🤝 Contributing

We welcome contributions! Please read our [Contributing Guidelines](.github/CONTRIBUTING.md) for:
- Code standards and review process
- Testing requirements
- Safety considerations for space systems
- Documentation expectations

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **NASA**: CCSDS standards and Basilisk simulation framework
- **FreeRTOS Community**: Real-time kernel and POSIX port
- **ROS 2 Community**: Robotics middleware and lifecycle management
- **Open Source Contributors**: Unity, CMock, littlefs, and testing tools

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/hkevin01/spacecraft-vms/issues)
- **Discussions**: [GitHub Discussions](https://github.com/hkevin01/spacecraft-vms/discussions)
- **Email**: support@spacecraft-vms.org

---

**Built for the stars** ⭐ | **Tested on Earth** 🌍 | **Deployed in Space** 🚀
