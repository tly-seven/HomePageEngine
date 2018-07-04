---
title: "Visualizing API Usage Examples at Scale: 大规模可视化 API 用例"
date: 2018-07-04T20:18:38+08:00
tags: ["数据可视化", "CHI"]
cover: "/images/blogs/chi/API2.png"
---

随着库和 API 在数量和复杂性上的急速增长，在编程中，高效正确的使用 API 是一个关键的挑战。开发者通常需要搜索代码示例来学习 API，但开发者只能人工浏览一部分示例，这部分示例可能不能满足他们的需求。本文的目标是提供一个更好的工具 EXAMPLORE，用于探索海量代码示例的集合。

<!--more-->

[原文链接：Visualizing API Usage Examples at Scale](https://dl.acm.org/citation.cfm?doid=3173574.3174154)

# 一、介绍
- 背景：
	- API 之于 Coding 是无比重要的
	- 学习 API 时存在各种各样的困难：
		1. 过于笼统或过于具体的解释
		2. 缺乏多个 API 之间交互的理解
		3. 缺乏替代的使用
		4. 难以识别与 API 相关的程序语句和结构
	- 最大的困难：API 文档中，样例不够充分。代码样例对理解 API 起着无比重要的作用。
	- 程序员需要在线搜索代码样例和 API。然而，对于大量的在线代码，有效的浏览具有挑战性（实际上，由于时间和注意力有限，程序员通常只浏览一部分样例，导致代码存在一定的问题）
- 需求：
	- 通过对大量的代码样例的高效探索，更好的理解 API
- 现状：
	- API 使用挖掘技术：利用大量开源代码来自动推断 API 使用方式。但这种方式对程序员探索代码样例帮助有限
- 解决方案：EXAMPLORE
- 评估
- 贡献
	1. 可视化方法
	2. 实现：[Demo](http://examplore.cs.ucla.edu:3000/)
	3. 评估

# 二、相关工作
- 探索复杂对象集合的接口
- 用代码样例学习 API
- API 用法的挖掘和可视化

# 三、合成代码骨架
- 本骨架设计针对 Java API：
	1. 声明
	2. 前置方法调用
	3. 守卫：条件分支判断
	4. 返回值检查：检查 API 的返回值
	5. 后置方法调用
	6. 异常处理
	7. 资源管理：文件、流、sockets、数据库等资源的获取和释放
- 可以推广到类似语言，比如 C++、C，但需要附加组件来捕获其他编程范式中的 API 特征（例如：函数式编程）

![](/images/blogs/chi/API1.png)

# 四、场景：与代码分布进行交互
![](/images/blogs/chi/API2.png)

- 学习使用 FileInputStream object，采用 100 个 GitHub 上挖掘的包含 FileInputStream object 的代码样例。
	- 颜色标记：代码对应的骨架部分
	- 代码样例从短到长排序
	- 展示 Top 3 最普遍的用法，对每个骨架部分。bar chart 统计（总共占比），show more/less。
	![](/images/blogs/chi/API3.png)
	- 点击勾选筛选代码，联动交互
	
# 五、系统架构和实现
- 数据收集：爬虫
- 数据处理：对代码分析和分类
- 可视化：渲染

# 八、讨论和局限性
- 需要更多的研究，更好地把握表现力与视觉复杂性的平衡。
- 现阶段不防范陈旧的或低质量的代码用例，需要改进。
- 代码用例的排序方式不够完善。

# 我的思考
- 优点：
	- 数据收集和处理的方式
	- 集合社区的智慧，有效的解决了问题
	- 划分骨架、汇总分析，有效的增强了表现力（表现了一个 API 的各个部分的注意点），并平衡了视觉复杂性
- 缺点：
	- 可视化方面没有太多亮点
	- 需要更多的研究，更好地把握表现力与视觉复杂性的平衡。
	- 代码用例的质量、排序方式问题