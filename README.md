# Wheel-Legged Robot (WLR)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

双足轮腿机器人——一个以学习软件与算法为目标的机器人项目。

## 项目目标

本项目旨在通过构建一个双足轮腿机器人，系统性地学习以下技术：

| 技术领域 | 具体内容 |
|----------|----------|
| **Linux** | Ubuntu 22.04 系统管理、嵌入式部署 |
| **ROS2** | Humble Hawksbill，机器人中间件与工具链 |
| **FOC** | 磁场定向控制，BLDC 电机高精度驱动 |
| **ESP32** | 实时嵌入式系统，PlatformIO 开发 |
| **控制算法** | 平衡控制 (PID / LQR / MPC)、步态规划 |
| **状态估计** | IMU 姿态解算、扩展卡尔曼滤波 (EKF) |
| **仿真** | Gazebo / Webots 纯软件仿真 |

## 硬件架构

```
┌─────────────────────────────────────┐
│          Raspberry Pi 4/5           │
│      Ubuntu 22.04 + ROS2 Humble     │
│   (状态估计 / 控制 / 导航 / 通信)      │
└──────────────┬──────────────────────┘
               │ UART (自定义协议)
┌──────────────┴──────────────────────┐
│            ESP32 (主控)              │
│    SimpleFOC + 实时控制回路          │
│    (FOC 电机驱动 / IMU 采集)         │
└──┬──────────┬──────────┬───────────┘
   │          │          │
┌──┴──┐   ┌──┴──┐   ┌──┴──┐
│左腿 │   │右腿 │   │左轮 │  ...
│髋·膝·踝│  │髋·膝·踝│  │右轮 │
└─────┘   └─────┘   └─────┘
```

## 目录结构

```
wheel_legged_robot/
├── docs/                  # 文档
│   ├── architecture.md    # 系统架构
│   ├── getting_started.md # 环境搭建
│   ├── references.md      # 参考资料
│   └── notes/             # 学习笔记
├── ros2_ws/src/           # ROS2 功能包
│   ├── wlr_description/   # URDF 机器人模型
│   ├── wlr_msgs/          # 自定义消息接口
│   ├── wlr_bringup/       # 启动配置
│   ├── wlr_controller/    # 平衡与步态控制
│   ├── wlr_kinematics/    # 运动学
│   ├── wlr_state_estimation/ # 状态估计
│   ├── wlr_driver/        # ESP32 通信驱动
│   ├── wlr_teleop/        # 遥控
│   └── wlr_sim/           # 仿真
├── firmware/              # ESP32 固件
│   ├── common/            # 公共库
│   ├── motor_controller/  # FOC 电机控制
│   ├── imu_reader/        # IMU 驱动
│   └── communication/     # 通信协议
├── scripts/               # 辅助脚本
└── .github/workflows/     # CI/CD
```

## 开发路线

1. **仿真先行** — 在 Gazebo 中建立 URDF 模型，实现平衡控制算法
2. **固件独立** — ESP32 + SimpleFOC 独立调试每个电机
3. **系统集成** — ROS2 ↔ ESP32 通信打通，真机部署
4. **进阶功能** — 步态规划、视觉 SLAM、跳跃控制

## 快速开始

详见 [`docs/getting_started.md`](docs/getting_started.md)

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/wheel_legged_robot.git
cd wheel_legged_robot

# 运行仿真
cd ros2_ws
colcon build
source install/setup.bash
ros2 launch wlr_sim gazebo.launch.py
```

## 参考资料

所有参考链接、论文、同类项目整理在 [`docs/references.md`](docs/references.md)
