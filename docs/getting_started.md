# 开发环境搭建指南

## 前置要求

- Ubuntu 22.04 (推荐双系统或 WSL2)
- Python 3.10+
- Git
- 基本命令行技能

## 1. 安装 ROS2 Humble

```bash
# 添加 ROS2 源
sudo apt update && sudo apt install curl gnupg lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# 安装
sudo apt update
sudo apt install ros-humble-desktop
sudo apt install ros-dev-tools

# 设置环境变量
echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

## 2. 安装仿真环境

### Gazebo

```bash
sudo apt install ros-humble-gazebo-ros-pkgs
sudo apt install ros-humble-gazebo-ros2-control
```

### Webots (备选)

```bash
# 从官网下载 https://cyberbotics.com/
# 或 snap 安装
sudo snap install webots
```

## 3. 安装 ESP32 开发工具

### PlatformIO (推荐)

```bash
# 安装 PlatformIO Core
python3 -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/master/scripts/get-platformio.py)"

# 或使用 VS Code 插件 "PlatformIO IDE"
```

### SimpleFOC 库

在 `firmware/` 目录下的 `platformio.ini` 中添加：

```ini
lib_deps =
    askuric/Simple FOC@^2.3.0
```

## 4. 克隆并构建本项目

```bash
git clone https://github.com/YOUR_USERNAME/wheel_legged_robot.git
cd wheel_legged_robot

# 构建 ROS2 工作空间
cd ros2_ws
rosdep install -i --from-path src --rosdistro humble -y
colcon build --symlink-install
source install/setup.bash
```

## 5. 运行仿真

```bash
# 启动 Gazebo 仿真 (待开发)
ros2 launch wlr_sim gazebo.launch.py

# 启动遥控节点
ros2 run wlr_teleop keyboard_control
```

## 6. 烧录 ESP32 固件

```bash
cd firmware/motor_controller
pio run --target upload
pio device monitor
```

## 开发工具推荐

| 工具 | 用途 |
|------|------|
| VS Code | 通用编辑器 |
| rqt / rviz2 | ROS2 可视化与调试 |
| PlatformIO IDE | ESP32 固件开发 |
| plotjuggler | 实时数据绘图 |
| serialplot | 串口数据可视化 |
