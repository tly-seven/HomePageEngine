---
title: "B-Planner：利用大规模出租车GPS轨迹规划双向夜间公交路线"
cover: "/images/B-Planner0.jpg"
tags: ["数据挖掘", "TITS"]
date: 2018-11-27T18:35:37+08:00
---

公交车是城市中一种经济方便的交通方式，然而大部分公交在夜间都停止运行，为了为夜间出行的人提供一种低成本的绿色交通方式，许多城市都开始规划夜间公交路线。然而，人工调研成本高且适应力弱。而本文利用出租车轨迹数据进行了夜间公交线路规划问题的探索。具体来说，本文提出了一种两层方法，在第一层中进行热点区域挖掘，在第二层进行线路规划。为了验证该方法的有效性，本文作者采用真实世界数据集进行试验和评估。

<!--more-->

[原文链接：B-Planner: Planning Bidirectional Night Bus Routes Using Large-Scale Taxi GPS Traces](/files/B-Planner.pdf)

# 一、介绍

- 背景：公交车。
- 问题：夜班公交车路线规划。
- 现状：人工调研，缺点是成本高，且城市路网交通变化快，适应力弱。
- 解决方案：
  - 思路：
      - 利用出租车轨迹规划夜班公交车线路，尽可能多覆盖乘客。
      - 可分为两个子问题：确认候选公交站点、路径选择。
  - 挑战：
      - 确认候选公交站点
      - 乘客数量和旅行时间的权衡：站点影响乘客数和旅行时间
      - 乘客流累计效果：站点数量和乘客流数量的权衡
      - 动态乘客流：时变因素
      - 不对称的乘客流和旅行时间：双向变化因素
  - 方法：两阶段方法
      - 阶段一：通过聚类和分割热区，确定备选站点
      - 阶段二：多种策略，最佳路径规划

![B-Planner2](/images/B-Planner2.png)

- 贡献：
  - 两阶段方法解决夜班公交车路径规划问题
  - 利用乘客上下车数据聚类热点区域的方法
  - 构建和修建有向公交路径图->BPS算法
  - 通过计算不同路径、不同频率下最大乘客数量确定夜班公交容量



# 三、候选公交车站点确认

- 步骤：
  - 选择热点单元：划分网格、标记热点单元
  - 合并和分裂：合并邻近（不一定邻接）热点单元形成热区、将大区划分为可步行范围的小区
  - 选择公交站点：选择区域内合适单元，作为公交站点



# 四、公交路径选择

- 步骤：
  - 近似乘客流和旅行时间
  - 公交路径选择方法：
      1. 构建公交路线图：根据约束和条件构建图、迭代移除无效节点和边来修剪图
      2. 自动生成备选公交路径：利用两个贪心算法
      3. 选择最佳路径：给定旅行时间约束，比较乘客覆盖率
- 乘客流和旅行时间估计：
  - 两个矩阵：假设不考虑时变因素、平均化
  - 最大等待时间（发车频率）

![B-Planner1](/images/B-Planner1.png)

- 构造公交路线图：
  - 要求：旅行时间、乘客流
  - 约束和条件：
      - 站之间距离不能过大
      - 每站都在向终点方向移动
      - 离起点越来越远
      - 离终点越来越近
      - 没有过于曲折的路径
  - 图构造和修剪
      - 图构造：给定起点和终点，遍历其中的站点，根据约束条件（地理的）构造图
      - 图修剪：删除无效节点（入/出度为0的节点）

![B-Planner3](/images/B-Planner3.png)

- 自动生成备选公交路径
  - 基于概率的传播算法（PBS）
      - 定义：
          - 支配：如果 $T(R_i) \leq T(R_j)$ 且 $Num(R_i) > Num(R_j)$，则称 $R_i$ 支配 $R_j$。T为Time，Num为乘客数量。
          - Skyline route：不被支配的route
      - 算法：
          - 根据构造的图，迭代生成不同路径（只考虑单向）
          - 其中，高累计客流的下一站拥有更高的随机被选取概率
          - 得到Skyline routes集，当routes集始终不变时停止
      - Baseline：
          - 每步Top-K Nodes传播算法
  - BPS算法：双向运行PBS算法，双向站点可以不一样



# 五、实验评估

- 公交车站评估

![B-Planner4](/images/B-Planner4.png)

- 公交车路径选择算法评估：
  - 收敛度
  - 参数敏感度：$T_1$ 聚类范围、$T_2$ 行走可达范围、$\delta$ 站距离
  - 候选路线统计
  - 天际线路径
  - 和基线 top-K 算法比较：有利于发现更好的路径，未比较运算效率。

  ![收敛度](/images/B-Planner5.png)

  ![基线算法比较](/images/B-Planner6.png)

- 双向 vs 单向公交车路径

  ![B-Planner7](/images/B-Planner7.png)

  ![B-Planner9](/images/B-Planner9.png)

- 实际路线比较、对出租车服务的影响

  ![B-Planner8](/images/B-Planner8.png)

- 公交容量分析



# 我的思考

- 优点：
  - 很好的分解、描述和解决了问题
  - 评估的很具体
- 缺点：
  - 算法比较naive，感觉都是拍拍脑袋就能想出来的，效率也比较堪忧。
