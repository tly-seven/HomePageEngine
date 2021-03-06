---
title: "Clustervision：无监督聚类的视觉监督"
date: 2018-06-01T11:14:13+08:00
tags: ["数据可视化", "TVCG"]
cover: "/images/Clustervision1.png"
---

聚类算法是无监督机器学习的一种常见类型，对于汇总和聚合复杂多维数据以使其更易于解释是很有帮助的。有多种多样的聚类方法，如 K-means、凝聚聚类、DBSCAN、光谱聚类。然而，现阶段存在一个问题：对于不同的用户，关注不同数据集的不同层次和方面，什么算法和参数能得到一个最好的聚类结果？这一点往往是通过专家的经验去判断和解决。而本文提出了 Clustervision，为用户计算和评估所有的聚类，并推荐其中高质量的聚类，帮助用户更好的理解数据并激发创造力。


<!--more-->

[原文链接：Clustervision: Visual Supervision of Unsupervised Clustering](/files/Clustervision.pdf)

# 一、介绍
- 背景：
	- 聚类算法是无监督机器学习的一种常见类型，对于汇总和聚合复杂多维数据以使其更易于解释是很有帮助的。
	- 有多种多样的聚类方法，如 K-means、凝聚聚类、DBSCAN、光谱聚类
- 需求：
	- 什么算法和参数能得到一个最好的聚类结果
	- 不同的用户关注数据集的不同的层次和方面
- 现状：
	- 尚无系统的聚类探索和研究工作
- 解决方案：
	- 提出了 Clustervision，满足了这些需求，为用户计算所有合理的集群结果并推荐其中高质量的集群。
	- 质量高低，是通过反映聚类不同方面的各种指标评估来确定的
	- 目标不仅是简单地展示各个高分聚类结果，而是更好的理解数据并激发创造力
	- 根据分析任务，对数据加以约束
- 评估：
	- 电子医疗数据，案例分析。
- 贡献：
	- 交互式可视分析系统 Clustervision 的设计和实现。
	- 一个案例分析：数据科学家使用 Clustervision，在电子健康数据中，寻找心脏病病人的聚类。

# 二、相关工作
## 2.1 聚类技术和方法
### 2.1.1 聚类算法分类
- 基于质心的方法：
	- eg：K-means
	- 参数：集群数量
	- 优点：利于表示集群的意义
- 基于连接的方法：
	- eg：层次、凝聚方法
	- 参数：距离
	- 优点：树状图
- 基于密度的方法：
	- eg：DBSCAN、OPTICS
	- 参数：密度
	- 优点：离群点
- 低维嵌入：
	- eg：光谱聚类
	- 参数：集群数量、将被映射到的低维数量
	- 优点：当集群没有完全由质心描述时很有用
- 概率聚类方法：
	- eg：高斯混合模型、潜在狄利克雷分配
	- 参数：对应概率分布的参数
	- 优点：更忠实的代表数据（对用户也更难理解）
- 上述方法的补充：交互式聚类，用户对算法提供反馈，也是一个活跃的研究领域。

### 2.1.2 聚类算法质量指标
- 常用指标
	- Calinski-Harabaz 指数：集群间方差和集群内方差的比值。
	- 轮廓系数：一个点和所属集群的相似程度，与其他集群相似程度的对比。
	- Davies-Bouldin 指数：和 Calinski-Harabaz 指数相似，定义为集群内分散和集群间分散的比值（所有集群上的平均）
	- 差距统计：随机排列数据后的聚类，并与无聚类结构的空引用分布作比较
	- S(Dbw)有效性指标：通过集群紧密型、分离性和密度来评估聚类效果和质量
- 指标的有效性：
	- 指标的有效性有待评估，但已有研究从 5 个方面（单调性、噪声、密度、子集群和偏态分布）调查和探究了 11 个指标。

### 2.1.3 获得最佳聚类结果。
- 尚无系统的方法，一个选择是“总结多个聚类方法运行的结果”，现有研究成果包含：
	- 聚类聚合：找到和其他聚类结果都相符的聚类结果
	- 元聚类：用户自主根据需求，选择合适的聚类结果
	- “将数据聚类集合进行聚类”。
	- “一个生成多样化、高质量聚类的框架，通过抽样高质量聚类并选择 k 个特征代表”
	- “子空间聚类”：通过整合特征相关性评估和聚类，在数据集的不同子空间找聚类
	- “共识聚类”：在多个聚类结果中寻找共识，来确定数量和评估聚类稳定性。
- Clustervision 的方法：
	- 定义：使用多种测量指标来评估聚类质量，使结果更容易解释
	- 原因：聚类总结法是难以解释的

## 2.2 聚类可视分析系统
- 现已有相当大量的研究，对于聚类可视分析系统
- 有的系统支持用户提供反馈
- 有的系统支持用户生成和比较多个聚类结果
- Clustervision，与之前的工作不同之处在于：
	- 让用户基于质量指标排名和比较多个聚类结果
	- 提供基于特征的总结
	- 允许用户通过约束来应用专业经验，来更好的聚类

# 三、设计目标
1. 比较聚类结果：从质量、聚类、技术算法、参数等多方面
2. 探索某个聚类结果：比较该聚类结果中的聚类们，从特征、质量、数据点等方面
3. 探索单个数据点：了解数据点的细节，并能评估相似和不同。
4. 理解聚类的原因：即理解为何数据点聚集和分离。
5. 获得最佳聚类结果：基于用户不同分析任务带来的不同约束。

# 四、系统
## 4.1 运行实例：集群的快乐
- 故事：
	- 数据集：相似的画的集群，67 个特征。
	- 方式：k-means，k = 10
	- 结果：有的集群结果很清晰，有的却没有帮助

## 4.2 工作流
- A: 聚类结果 Rank
- B：探索某个聚类结果
- C：某个聚类结果中，多个聚类进行比较
- D：探索某个聚类的细节
- E：探索数据点的细节

![](/images/Clustervision1.png)

### 4.2.1 聚类结果排名列表
- 排名计算：
	- 服务器计算多个聚类结果，每个聚类结果使用 5 个质量参数来分析：Calinski-Harabaz 指数, 轮廓系数, Davies-Bouldin 指数, S(Dbw), 差距分析。
	- 每个质量指标前三好的聚类结果将呈献给用户，于是共有 15 个聚类结果。
	- 为了确保聚类结果不要过于相似，一个聚类结果只有在至少 5% 不同于其他 top 结果时，才会被认为是 top 结果。
- 可视化设计
	- 概览：每行代表一个聚类结果，包括
		- 一个数字排名索引
		- 一个聚类结果概要
		- 一个质量指标雷达图。
	- 聚类配色：
		- 使用一个 20 色的调色板
		- 最小化不同聚类结果间颜色改变的点的数量：最低成本完美匹配问题，使用 Hungarian algorithm 来保持颜色一致性。
		- Range Slider：调整聚类尺寸	

		![](/images/Clustervision2.png)

### 4.2.2 Projection
- 二维散点图：
	- 降维，坐标轴没有明确的意义
	- 数据点的位置是稳定的
	- 可以选择不同的降维技术以及 SuperPoint 范围

	![](/images/Clustervision3.png)

### 4.2.3 基于特征的视图：Ranked Features and Parallel Trends
- 作用：和映射视图协调工作，展现特征信息
- 挑战：难以解释为何形成这样的聚类结果
- 解决方案：
	- 利用单变量统计，计算每个特征与每个集群是否存在统计学的显著关系。
	- 将此视为一个分类任务，每个集群是一个类，为每个特征计算方差分析。
	- 每个特征的分数基于方差分析的 F 值，使我们能根据重要性排序特征。
- Parallel Trends 中，
	- 纵轴代表每个点的特征，为简化复杂度，化为集群表示。
	- 纵轴上每个集群的间隔代表 95% 置信区间的标准偏差，虚线代表集群对于该特征的均值
	- 表示每个特征和每个集群的相关联程度
- Ranked Features 用于解决 Parallel Trends 的可拓展性问题。Ranked Features 中 checkbox 的选取和取消选取，用于添加和移除特征到 Parallel Trends


	![](/images/Clustervision4.png)

### 4.2.4 Cluster Detail and Data Point
- Cluster Detail
	- 展示了选中集群的各类指标，未选择集群将以半透明的形式作为参照
	- 展示了最中心的五个点和最边缘的五个点
- Data Point
	- 展示数据点特征的实际值
	- 也展示了其他数据点的上下文，通过展示数据分布
		- 离散的：直方图
		- 连续的：kernel density plot

![](/images/Clustervision5.png)
![](/images/Clustervision6.png)

### 4.2.5 聚类约束
- 用户可以选择多个点，告诉系统它们必须在同一个聚类或不同聚类

### 4.2.6 比较聚类结果
![](/images/Clustervision7.png)


# 五、案例研究



# 六、结论和讨论
- 工作总结
- 挑战：
	- 用户可以从更多稳定的指标中受益
	- 给用户更多控制，对于距离函数
	- 拓展，除了静态特征，还有时序数据（在健康问题中是一个重要因素）
- 未来展望：
	- 在各行各业，利用先进的聚类工具。Clustervision 是第一步。


# 我的收获
- 对聚类算法、质量指标等相关工作的全面介绍
- 对多聚类结果从浅入深的探索过程，包括
	- 关注，最小化不同聚类结果间颜色改变的点的数量
	- 多属性聚类结果，降维映射到 2 维空间
	- 聚类特征的比较和探索
	- 点的探索
	- 聚类的比较









