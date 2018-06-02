---
title: "Rankexplorer：大型时序数据的排名变化可视化"
date: 2018-06-02T13:08:16+08:00
tags: ["数据可视化", "TVCG"]
cover: "/images/blogs/vis/RankExplorer1.png"
---

时序数据是当今热门应用数据，其中暗含了趋势、主题、异常、关系等知识。人们既关心数据值随着时间的变化，也关心数据的排名。例如：对于 Google 查询关键词，专家既关心词的搜索数量，也关心相对排名。这些数据随着时间变化。现阶段，叠图是这方面最为广泛使用的可视化技术。然而，叠图存在着不能展现时序变化的缺陷。增强叠图又容易导致混乱。所以，本文作者提出了 RankExplorer，基于 ThemeRiver 的可视化方法来展现排名随时间的变化。

<!--more-->

[原文链接：RankExplorer: Visualization of Ranking Changes in Large Time Series Data](/files/papers/RankExplorer.pdf)

# 摘要和介绍
- 需求：时序数据是当今热门应用数据，其中暗含了趋势、主题、异常、关系等知识。人们既关心数据值随着时间的变化，也关心数据的排名。
- 例子：Google 查询关键词，专家既关心词的搜索数量，也关心相对排名。这些数据随着时间变化。
- 现状：叠图是广泛使用的技术。
	- 原因：其对时间序列数据的连续性、总结性和单独个体的展示。
	- 局限性：但传统叠图不能直观展示排名随时间的变化。
	- 解决方式：增强叠图，改变垂直层次序列来表示排名。
	- 缺陷：大量时间序列数据集时，频繁地改变容易造成混乱。
- 改进现状的解决设计思路：
	- 保持叠图的直观和属性性并解决其缺陷：大规模时序数据集中，难以表达排名改变的演化模式。
- 解决方式：RankExplorer，基于 ThemeRiver 的可视化方法来展现排名随时间的变化。包括四个部分：
	- 一种分割方法，将大量时间序列曲线分解成可管理数量的排名类别。
	- 一种拓展的 ThemeRiver 视图，嵌入了 bars 和 glyphs。展示了关于每一个排名类别的聚合值的时间演化，以及排名类别的内容变化（outer and inner content changes）。
	- 趋势曲线，展示了排名随时间变化的程度。
	- 丰富的用户交互，支持排名变化的交互式探索。
- 评估：
	- 评估方式：真实时序数据的 case studies。
	- 结果：RankExplorer 可以揭示，与传统可视化中的可能被隐蔽的排名变化有关的底层模式
- 贡献：
	- 拓展了 ThemeRiver 可视化，通过 embedded color bars and changing glyphs，传达了随着时间的外部和内部变化。
	- 提出了一种自适应分割方法，用于分割时间序列数据，来更高效的理解。
	- 允许用户探索排名的改变，在不同细节等级和不同层次部分，通过丰富的交互。


# 三、系统概述
![](/images/blogs/vis/RankExplorer1.png)
![](/images/blogs/vis/RankExplorer2.png)

- Summary View：ThemeRiver + 趋势曲线：
	- Ranking：计算每个时间点的 ranking，并统计总体变化。
	- Categories：在每个时间点，数据被分为数个分类，并计算聚合值。
	- 时序改变：
		- 每个分类内的内容会随着时间改变
		- 一些 item 会 move into or out of the category（我们叫它 flowing-in 和 flowing-out item）
	- Interactions：查询、缩放、过滤
- Statistical View
- Line Chart View

# 四、可视化设计
## 4.1 设计理由
- 设计目标：表达 item 的值和排名的时序变化。
- 最简单的方式：
	- 2 个 line chart，一个表值一个表排名。
	- 缺点：
		- 数据量大时混乱
		- 上下文切换成本。
- ThemeRiver：
	- 将每个 item 作为一个 layer，layer 宽度编码了 item 的值。
	- 缺点：
		- 数据量大时混乱
		- 只能编码值的变化，无法编码排名的变化
- 解决 ThemeRiver 的缺点：
	1. 将数据项分割为可控数量的分类。
	2. 用 color bars 和 changing glyph 增强 ThemeRiver

## 4.2 分割
- 分割标准：
	1. 每层平均高度相近
	2. 外部变化应该尽可能少，每层相对尽可能独立。这样有助于用户关注特定层时减少受到其它层的干扰。
- 数学模型

## 4.3 概要视图
### 4.3.1 趋势曲线编码方案
- 曲线高度代表改变程度（0：没有改变，1：几乎全部改变）
- 测量排名改变的需求：
	1. 要考虑数据项的相对排名改变
	2. 一个项的排名改变越大，对总体排名改变的影响越大
	3. 新数据项的加入和旧数据项的消失
- 数学模型：拓展了反转数字的概念

### 4.3.2 Color Bars 编码方案
![](/images/blogs/vis/RankExplorer3.png)

- Color Bars 代表层间的排名改变
- 特殊的色彩编码颜色：
	- 第一次出现：白色
	- 重新出现：深绿色
	- 缩放后：深红编码来自上层，深绿编码来自下层
- 非相邻的、遥远的层次之间的内容变化是令人关注的，使用了两个交互来增强这些 color bar：
	- 非线性缩放：根据层之间距离非线性的缩放高度。（图中来自两端的层更远，中央的层更近）
	
	![](/images/blogs/vis/RankExplorer4.png)

	- 过滤：可以设置下限，来隐藏 change 不足的 bar

### 4.3.3 Changing Glyphs 编码方案
![](/images/blogs/vis/RankExplorer5.png)

- Changing Glyphs 用于表达单层内的改变

## 4.4 统计视图和折线图视图
- 需要更多更细节的信息

![](/images/blogs/vis/RankExplorer6.png)

# 五、案例分析
- Bing 三个月搜索引擎数据
- 1955 —— 2010 美国财富 500 强分析


