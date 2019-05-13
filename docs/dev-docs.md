## 对已有材料的分析

1. Mars4_5
	一个MIPS汇编语言的汇编模拟器，需要java环境 
	具体怎么操作这个博客写的简单易懂：https://blog.csdn.net/y_universe/article/details/82875244
	压缩一份zip，一份rar
	感觉可以用来展示，应该要交给FKY了……

2.d1MIPS指令集合和汇编数据通路ppt
	前面简单讲了一下MIPS指令集，有点模糊
		MIPS指令集（很详细）：https://blog.csdn.net/ben_chong/article/details/51794093
		感觉应该注意一下op和funct的关系
	后面手把手告诉咱们怎么设计出一个简单的单周期CPU（但是没有源代码）
		学长的那个单周期应该就是照着这个做的……

3.结构示例
	文件夹里面全是空的子文件和文件夹，就是给咱们看一下CPU构成部件有什么。
	上面ppt里的例子
	感觉没什么用……

4.d2单周期控制和多周期处理器设计
	前面部分完成了单周期CPU设计的最后部分（教咱们写控制器：通过op和funct生成输入信号）
	后半部分是怎么改成多周期的
		如何解决竞争问题（控制信号来的时候，寄存器或内存里的数不稳定之类的）
		……这部分我还没看完

5.后面两个pdf应该是咱们将来用的教材的电子版，一本体系结构， 一本计组
	感觉现在没什么用……

## 支持的指令

- R型
  - add
  - addu
  - sub
  - subu
- I型
  - ori
  - lui
- 存储器访问指令
  - lw
  - sw
- 分支指令
  - beq

## Contoller table


见csv文件

## 常见问题以及解决方法

### 不太理解cpu的工作原理

需要通读教程，对每一个元件根据对应的功能来推理。

### 

#### lui

R[rt] = {imm, 16'b0}

#### ExtOp

00 : Unsigned ext
01 : Signed ext
10 : ext for lui
