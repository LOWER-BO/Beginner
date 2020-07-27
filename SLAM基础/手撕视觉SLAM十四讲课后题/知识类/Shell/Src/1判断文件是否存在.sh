#!/bin/bash

if [ $# -eq 0 ] ;then
   echo "未输入任何参数,请输入参数"
   echo "用法:$0 [文件名|目录名]"
fi
#$0 —— 文件名称
#$# —— 输入参数的个数
if [ -f $1 ];then
    echo "该文件,存在"
    ls -l $1
else
    echo "没有该文件"
fi
# -f 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。
#ls -l 除文件名称外，亦将文件型态、权限、拥有者、文件大小等资讯详细列出
if [ -d $2 ];then
    echo "该目录,存在"
    ls -a $2
else
    echo "没有该目录"
fi
# -a 检测文件是否是目录，如果是，则返回 true。
#ls -a显示所有文件及目录 (ls内定将文件名或目录名称开头为"."的视为隐藏档，不会列出)
