#!/bin/bash
set -e

# Spacecraft VMS - Build Script
# Builds firmware and ROS 2 components

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

# Function to build firmware
build_firmware() {
    info "Building firmware..."
    cd "$PROJECT_ROOT/src/firmware"

    # Clean previous build
    rm -rf build

    # Configure and build
    cmake -B build -DBUILD_POSIX=ON -DCMAKE_BUILD_TYPE=Release
    cmake --build build --config Release

    info "Firmware build complete"
}

# Function to build ROS 2 workspace
build_ros2() {
    info "Building ROS 2 workspace..."

    if [ ! -d "$PROJECT_ROOT/src/ros2_ws/src" ]; then
        warn "ROS 2 workspace not found, skipping..."
        return 0
    fi

    cd "$PROJECT_ROOT/src/ros2_ws"

    # Source ROS 2 environment
    if [ -f "/opt/ros/humble/setup.bash" ]; then
        source /opt/ros/humble/setup.bash
        colcon build --symlink-install
        info "ROS 2 build complete"
    else
        warn "ROS 2 Humble not found, skipping ROS 2 build"
    fi
}

# Function to run tests
run_tests() {
    info "Running firmware tests..."
    cd "$PROJECT_ROOT/src/firmware"
    ctest --test-dir build --output-on-failure

    if [ -d "$PROJECT_ROOT/src/ros2_ws" ]; then
        info "Running ROS 2 tests..."
        cd "$PROJECT_ROOT/src/ros2_ws"
        if [ -f "/opt/ros/humble/setup.bash" ]; then
            source /opt/ros/humble/setup.bash
            source install/setup.bash
            colcon test --event-handlers console_direct+
        fi
    fi
}

# Main build process
main() {
    info "Starting Spacecraft VMS build..."

    # Parse command line arguments
    BUILD_FIRMWARE=true
    BUILD_ROS2=true
    RUN_TESTS=false

    while [[ $# -gt 0 ]]; do
        case $1 in
            --firmware-only)
                BUILD_ROS2=false
                shift
                ;;
            --ros2-only)
                BUILD_FIRMWARE=false
                shift
                ;;
            --test)
                RUN_TESTS=true
                shift
                ;;
            --help)
                echo "Usage: $0 [options]"
                echo "Options:"
                echo "  --firmware-only    Build only firmware components"
                echo "  --ros2-only       Build only ROS 2 components"
                echo "  --test            Run tests after building"
                echo "  --help            Show this help message"
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                exit 1
                ;;
        esac
    done

    # Build components
    if [ "$BUILD_FIRMWARE" = true ]; then
        build_firmware
    fi

    if [ "$BUILD_ROS2" = true ]; then
        build_ros2
    fi

    # Run tests if requested
    if [ "$RUN_TESTS" = true ]; then
        run_tests
    fi

    info "Build complete!"
}

# Run main function
main "$@"
