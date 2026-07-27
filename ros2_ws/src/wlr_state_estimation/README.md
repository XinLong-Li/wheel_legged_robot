# WLR State Estimation

状态估计节点，融合多传感器数据。

## 计划功能

- IMU 姿态解算 (Madgwick/Mahony 滤波器)
- 扩展卡尔曼滤波 (EKF) — 融合 IMU + 轮式里程计 + 关节编码器
- 机器人身体位姿估计 (base_link → odom)
