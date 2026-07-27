#!/bin/bash
# Wheel-Legged Robot 开发环境一键安装脚本
set -e

echo "========================================="
echo "  Wheel-Legged Robot 环境安装"
echo "========================================="

# --- ROS2 Humble ---
echo "[1/5] Installing ROS2 Humble..."
if ! dpkg -l | grep -q ros-humble-desktop; then
    sudo apt update
    sudo apt install -y curl gnupg lsb-release
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    sudo apt update
    sudo apt install -y ros-humble-desktop ros-dev-tools
    echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
else
    echo "  ROS2 Humble already installed, skipping."
fi

# --- Gazebo ---
echo "[2/5] Installing Gazebo..."
if ! dpkg -l | grep -q ros-humble-gazebo-ros-pkgs; then
    sudo apt install -y ros-humble-gazebo-ros-pkgs ros-humble-gazebo-ros2-control
else
    echo "  Gazebo already installed, skipping."
fi

# --- Python deps ---
echo "[3/5] Installing Python dependencies..."
sudo apt install -y python3-pip python3-colcon-common-extensions python3-rosdep
pip3 install --user numpy scipy matplotlib transforms3d

# --- PlatformIO ---
echo "[4/5] Installing PlatformIO (for ESP32)..."
if ! command -v pio &> /dev/null; then
    python3 -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"
    echo 'export PATH="$PATH:$HOME/.platformio/penv/bin"' >> ~/.bashrc
else
    echo "  PlatformIO already installed, skipping."
fi

# --- rosdep ---
echo "[5/5] Initializing rosdep..."
sudo rosdep init 2>/dev/null || true
rosdep update

echo ""
echo "========================================="
echo "  Installation Complete!"
echo "========================================="
echo ""
echo "Next steps:"
echo "  cd ros2_ws"
echo "  rosdep install -i --from-path src --rosdistro humble -y"
echo "  colcon build --symlink-install"
echo ""
echo "For ESP32 firmware:"
echo "  cd firmware/motor_controller"
echo "  pio run"
