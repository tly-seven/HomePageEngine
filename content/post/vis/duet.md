---
title: "Duet：协助数据分析新手进行成对比较"
cover: "/images/Duet1.png"
tags: ["数据可视化", "TVCG"]
date: 2018-10-03T16:40:51+08:00
---

数据分析新手常常在执行成对比较的底层操作时遇到麻烦。同时，他们常常难以理解和解释比较结果中蕴含的模式。因此，本文的作者开发了 Duet，一个可视分析系统，用于帮助数据分析新手克服成对比较中的执行障碍和解释障碍。同时，该系统利用了 Minimal Specification 技术，进行比较和推荐。

<!--more-->

[原文链接：Duet: Helping Data Analysis Novices Conduct Pairwise Comparisons by Minimal Specification](/files/Duet.pdf)

# 一、介绍
- 背景：成对比较，促进决策
- 问题：对数据分析新手来说，成对比较是有挑战的
- 例子：抓捕犯罪嫌疑人，对了解领域知识但不了解数据分析的警察
- 挑战：新手的两个障碍，包含执行障碍和解释障碍
	- 执行障碍：创建什么可视化、执行什么交互、如何查看模式
	- 解释障碍：将可视化和问题联系起来
- 解决方案：Duet
	- 简介：表格数据对象的成对比较
		- 对单个对象，推荐相似对象
		- 对多个对象，给出对象间的相似和不同
	- 执行障碍：Minimal Specification 技术。创建可视化，并展示底层策略和模式
	- 解释障碍：解释可视化
- 评估

# 二、相关工作
- 执行和解释障碍
- 成对比较工具
- 数据分析的推荐系统

# 三、设计需求
1. 可以灵活定义对象组
2. 防止用户被大量的推荐淹没
3. 允许用户保存感兴趣的推荐对象
4. 为新手提供解释（底层策略）

# 四、Duet 用户接口
- 五个主要组件：属性列表，数据表格，组和属性架，结果面板，关系映射
- 核心问题：识别复杂属性对象组
- 工作流：设置对象属性 -> 比较/推荐类似和不同对象 -> 对感兴趣的进行保存
	- 属性列表：列出所有属性，以供设置
	- 数据表格：列出所有对象及其属性，以供拖拽设置
	- 组和属性架：设置好的对象属性
	- 结果面板：双面，显示查询的对象、比较结果、推荐的类似对象和不同对象
	- 关系映射：显示保存的推荐对象关系

## 4.1 Overview
![](/images/Duet1.png)


## 4.2 属性列表、数据表格、组和属性架
![](/images/Duet2.png)

## 4.3 组和属性架、结果面板
![](/images/Duet3.png)
![](/images/Duet4.png)

## 4.4 关系映射
![](/images/Duet5.png)
![](/images/Duet6.png)

# 五、Minimal Specification 技术的实现
- 介绍：
  - 是一个成对比较和推荐的技术。
  - 当指定一个对象组时，推荐相似或不同的其他对象组。
  - 当指定两个对象组时，比较两个组，得到相似和不同的属性。
- 作者认为，对数据分析新手，浏览大量的统计距离值产生巨大的认知负担，所以将其转化为相似和不相似这个分类属性。
- 具体计算相似和不相似的没有细看，但感觉没有很特别。
- 缺失值处理：直接移除缺失值

![](/images/Duet7.png)

# 我的思考
- 可视化设计简单易懂，工作流紧密。紧扣本文主题，适合数据分析新手使用。
- Minimal Specification 技术，针对不同情况给出相应的处理。



