#!/bin/bash
set -e

# Spacecraft VMS - Test Script
# Runs comprehensive test suite

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to run firmware tests
test_firmware() {
    info "Running firmware tests..."
    cd "$PROJECT_ROOT/firmware"

    if [ ! -d "build" ]; then
        info "Building firmware first..."
        cmake -B build -DBUILD_POSIX=ON -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_FLAGS="--coverage"
        cmake --build build
    fi

    # Run unit tests
    ctest --test-dir build --output-on-failure --verbose

    # Generate coverage report if possible
    if command -v gcovr &> /dev/null; then
        info "Generating coverage report..."
        gcovr --exclude-unreachable-branches --print-summary --root .
        gcovr --html-details -o build/coverage.html --root .
        info "Coverage report generated: firmware/build/coverage.html"
    else
        warn "gcovr not found, skipping coverage report"
    fi
}

# Function to run static analysis
run_static_analysis() {
    info "Running static analysis..."
    cd "$PROJECT_ROOT/firmware"

    # Run cppcheck
    if command -v cppcheck &> /dev/null; then
        info "Running cppcheck..."
        cppcheck --enable=all --suppress=missingIncludeSystem --xml --xml-version=2 . 2> build/cppcheck-report.xml || true
        cppcheck --enable=all --suppress=missingIncludeSystem . || true
    else
        warn "cppcheck not found, skipping"
    fi

    # Run clang-tidy
    if command -v clang-tidy &> /dev/null; then
        info "Running clang-tidy..."
        find . -name "*.c" -not -path "./build/*" | xargs clang-tidy -- -I. -Iapp -Imiddleware -Isafety 2> build/clang-tidy-report.txt || true
    else
        warn "clang-tidy not found, skipping"
    fi
}

# Function to run ROS 2 tests
test_ros2() {
    info "Running ROS 2 tests..."

    if [ ! -d "$PROJECT_ROOT/src/ros2_ws/src" ]; then
        warn "ROS 2 workspace not found, skipping..."
        return 0
    fi

    cd "$PROJECT_ROOT/src/ros2_ws"

    # Source ROS 2 environment
    if [ -f "/opt/ros/humble/setup.bash" ]; then
        source /opt/ros/humble/setup.bash

        # Build if needed
        if [ ! -d "install" ]; then
            info "Building ROS 2 workspace first..."
            colcon build --symlink-install
        fi

        source install/setup.bash
        colcon test --event-handlers console_direct+
        colcon test-result --verbose
    else
        warn "ROS 2 Humble not found, skipping ROS 2 tests"
    fi
}

# Function to run integration tests
run_integration_tests() {
    info "Running integration tests..."

    # Add integration test logic here
    # For now, just run a smoke test
    cd "$PROJECT_ROOT/firmware/build"
    if [ -f "vms_posix" ]; then
        info "Running VMS POSIX smoke test..."
        ./vms_posix
        if [ $? -eq 0 ]; then
            info "Integration smoke test passed"
        else
            error "Integration smoke test failed"
            exit 1
        fi
    fi
}

# Main test process
main() {
    info "Starting Spacecraft VMS test suite..."

    # Parse command line arguments
    RUN_FIRMWARE=true
    RUN_ROS2=true
    RUN_STATIC=false
    RUN_INTEGRATION=false

    while [[ $# -gt 0 ]]; do
        case $1 in
            --firmware-only)
                RUN_ROS2=false
                shift
                ;;
            --ros2-only)
                RUN_FIRMWARE=false
                shift
                ;;
            --static)
                RUN_STATIC=true
                shift
                ;;
            --integration)
                RUN_INTEGRATION=true
                shift
                ;;
            --all)
                RUN_STATIC=true
                RUN_INTEGRATION=true
                shift
                ;;
            --help)
                echo "Usage: $0 [options]"
                echo "Options:"
                echo "  --firmware-only   Test only firmware components"
                echo "  --ros2-only      Test only ROS 2 components"
                echo "  --static         Run static analysis"
                echo "  --integration    Run integration tests"
                echo "  --all            Run all tests including static analysis and integration"
                echo "  --help           Show this help message"
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    # Run tests
    if [ "$RUN_FIRMWARE" = true ]; then
        test_firmware
    fi

    if [ "$RUN_STATIC" = true ]; then
        run_static_analysis
    fi

    if [ "$RUN_ROS2" = true ]; then
        test_ros2
    fi

    if [ "$RUN_INTEGRATION" = true ]; then
        run_integration_tests
    fi

    info "Test suite complete!"
}

# Run main function
main "$@"
