---
title: "TPFlow：用于大规模时空数据分析的渐进式分区和多维模式提取"
cover: "/images/TPFlow5.png"
tags: ["数据可视化", "TVCG"]
date: 2018-10-21T11:44:02+08:00
---

多维时空数据中蕴含着丰富的模式，常用于数据分析中，多视图交互式可视化是分析的经典方法。然而，这样的方法不能为分析师提供充分的分析指导，分析师需要迭代式的手动选择切片、查看和比较，这使得模式发掘更加困难。这篇工作将多维时空数据建模为张量，提出了一个新颖的分段秩一张量分解方法，该方法支持自动切片和发掘模式。基于这个方法，这篇工作提出了 TPFlow，一个支持从上到下的渐进式多维时空数据探索的视觉分析框架，可以减轻分析负担，良好的解决了多维时空数据探索的问题。

<!--more-->

[原文链接：TPFlow: Progressive Partition and Multidimensional Pattern Extraction for Large-Scale Spatio-Temporal Data Analysis](/files/TPFlow.pdf)

# 一、介绍
- 背景：
	- 多维时空数据可视化
	- 传统方法：数据缩减、多维视图、实时交互
- 问题：
	- 高度集成总览不足以提供有效的模式线索
	- 交互式操作（brush、filter、link...）进行模式发掘是复杂困难的
- 解决方案：
	- 算法：piecewise rank-one tensor decomposition，分段秩1张量分解。
	- 功能：自动寻找最优的张量分解方法，为每个分区导出模式。
	- 意义：减轻分析人员手动迭代数据不同切片发掘模式的负担。
	- 系统：TPFlow，Tensor Partition Flow。
- 评估：
	- 使用场景：三个数据集（出租车、销售、客流）
	- 专家访谈
- 贡献：
	- 算法
	- 框架
	- 使用场景

# 二、相关工作
1. 大范围多维时空数据可视化
2. 大范围多维时空数据挖掘

# 三、算法 
- 本节建议直接阅读原文

## 3.1 将时空数据建模为张量
- 张量：多维数组，例如交通流量张量有三个维度，位置、天、小时。
- 外积：三个向量的外积可以得到一个三维张量。
- 秩一张量：可以被向量外积表示的张量。

![](/images/TPFlow2.png)

- 张量分解：逐步迭代，每次确定最好的秩一近似张量（捕获了最突出的数据变化和模式）。之后每次为剩余张量进行迭代。
	![](/images/TPFlow1.png)
- 细节：
	1. 第一个近似张量可以总览数据
	2. 迭代持续至 cost 提升很小或迭代步数到达上限
	3. 最好的结果，最后一步 cost = 0，原始张量可以被完全分解。
	![](/images/TPFlow3.png)


## 3.2 分段秩一张量分解
- 问题：第一个子张量给了数据总览，但不能捕获数据的所有变化情况。
- 例子：交通流量在工作日和周末有不同的地理分布，而第一个张量平均利用了所有天的情况，于是这样的信息丢失了。
- 解决方式：分段秩一张量分解。
	- 步骤：给定维度，发掘和划分有相似特征的子张量（作为第一个子张量）。对每个子张量进行分解。
	- 发掘方式：组合问题，采用聚类算法。

![](/images/TPFlow4.png)

# 四、TPFlow
## 4.2 可视化和交互
- 基本可视化图表
	![](/images/TPFlow6.png)
- 偏差可视化
	![](/images/TPFlow7.png)
- 工作流：树状视图 + 维度特征视图
	- 树状可视化划分过程
	- 树节点的交互
	- 查看特征和比较

![](/images/TPFlow5.png)

# 五、用户场景
- 区域销售数据分析
- 客户在实体零售商的商店交通数据分析
- 纽约出租车交通数据

# 我的思考
## 优点
- 数据挖掘：
	- 之前习惯于从不同维度角度看数据，本文从张量分解角度，还利用了聚类（有点像层次结构）的方法。
	- 之前习惯于看相似几天的数据变化。本文却看相似数据在哪些天。
	- 之前不习惯只看数据的单个维度，但有时候单个维度也能表达重要信息。
- 可视化：
	- 偏差可视化
	- 柱状元素和树的使用
	- 多视图挖掘多维度特征

