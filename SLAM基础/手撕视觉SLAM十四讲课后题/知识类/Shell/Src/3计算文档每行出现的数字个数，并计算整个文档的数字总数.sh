#!/bin/bash 
######################################################### 
#计算文档每行出现的数字个数，并计算整个文档的数字总数 
######################################################## 
#使用awk只输出文档行数（截取第一段） 
n=`wc -l a.txt|awk '{print $1}'` 
#上面不是变量，应该linux的指令
#wc -l a.txt|awk '{print $0}'  3 a.txt
#wc -l a.txt|awk '{print $1}'  3
#wc -l a.txt|awk '{print $2}'  a.txt
sum=0 
#文档中每一行可能存在空格，因此不能直接用文档内容进行遍历 
for i in `seq 1 $n` 
#seq 1 10
#结果是1 2 3 4 5 6 7 8 9 10
do
 #输出的行用变量表示时，需要用双引号 
 line=`sed -n "$i"p a.txt` 
 #echo $line  每一行的信息
 #wc -L选项，统计最长行的长度 
 n_n=`echo $line|sed s'/[^a-c]//'g|wc -L` 
 #正则表达式，我也不怎么看的懂，细看https://www.runoob.com/regexp/regexp-rule.html
 #查找字符
 echo $n_n 
 sum=$[$sum+$n_n] 
done
 echo "sum:$sum"
