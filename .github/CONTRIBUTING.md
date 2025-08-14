# Contributing to Spacecraft VMS

Thank you for your interest in contributing to the Spacecraft Vehicle Management System! This project is designed for mission-critical applications, so we have specific guidelines to ensure quality and safety.

## Code of Conduct

This project follows a professional code of conduct. Please be respectful and constructive in all interactions.

## Development Setup

### Prerequisites

- Ubuntu 22.04 LTS (recommended)
- CMake 3.23+
- GCC 13+ or Clang 15+
- ROS 2 Humble
- Git

### Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/spacecraft-vms.git`
3. Install dependencies: `./scripts/setup_dev_environment.sh`
4. Build the project: `./scripts/build.sh`
5. Run tests: `./scripts/test.sh`

## Development Workflow

### Branching Strategy

- `main`: Production-ready code
- `develop`: Integration branch for features
- `feature/xxx`: New features
- `bugfix/xxx`: Bug fixes
- `hotfix/xxx`: Critical production fixes

### Coding Standards

#### C/C++ (Firmware)

- Follow MISRA-C:2012 guidelines
- Use C17 standard
- 4-space indentation
- Maximum 100 characters per line
- All functions must have documentation comments
- Use static analysis tools (cppcheck, clang-tidy)

```c
/**
 * @brief Brief description of the function
 * @param param1 Description of parameter 1
 * @param param2 Description of parameter 2
 * @return Description of return value
 */
ReturnType_t FunctionName(ParamType_t param1, ParamType_t param2)
{
    // Implementation
}
```

#### Python (ROS 2)

- Follow PEP 8
- Use type hints
- Use snake_case for functions and variables
- Use PascalCase for classes
- Maximum 88 characters per line (Black formatter)

```python
def function_name(param1: int, param2: str) -> bool:
    """Brief description of the function.

    Args:
        param1: Description of parameter 1
        param2: Description of parameter 2

    Returns:
        Description of return value
    """
    # Implementation
```

### Testing Requirements

- All new code must have unit tests
- Maintain >90% code coverage
- Integration tests for new features
- Hardware-in-the-loop (HIL) tests for firmware changes
- All tests must pass before merging

### Safety Requirements

For safety-critical components:

- Hazard analysis must be updated
- FMEA (Failure Mode and Effects Analysis) consideration
- Independent code review required
- Formal verification where applicable

## Pull Request Process

1. Create a feature branch from `develop`
2. Make your changes following coding standards
3. Add tests for new functionality
4. Update documentation
5. Run the full test suite
6. Submit a pull request to `develop`

### PR Checklist

- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] Static analysis passes
- [ ] Safety impact assessed

## Issue Reporting

Use the appropriate issue template:

- Bug reports: Include reproduction steps, environment details, and safety impact
- Feature requests: Include use cases, acceptance criteria, and implementation considerations

## Documentation

- Update README.md for user-facing changes
- Update API documentation for interface changes
- Update architecture documentation for design changes
- Use clear, concise language
- Include code examples where helpful

## Release Process

1. Feature freeze on `develop`
2. Create release branch: `release/vX.Y.Z`
3. Testing and bug fixes
4. Merge to `main` and tag
5. Deploy to production environment

## Getting Help

- GitHub Discussions for questions
- Issues for bugs and feature requests
- Code reviews for design feedback

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

Thank you for contributing to making spacecraft missions safer and more reliable!
