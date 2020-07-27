#!/bin/bash

echo "hello sh"
#打印信息

your_name="My name is zhaobo!"
echo $your_name
#Shell 变量 变量名和等号之间不能有空格

for file in $(ls ); do
    echo "这个路径下存在的文件:${file}" ##$file
done
#遍历和打印home文件的文件名称

for skill in C++ Python; do
    echo "I am good at ${skill}"
done
#for循环遍历和打印
