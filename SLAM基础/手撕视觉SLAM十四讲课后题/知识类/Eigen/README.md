## Eigen库的模块及其头文件

Eigen库被分为多个功能模块，每个模块都有自己相对应的头文件，以供调用。 其中，Dense模块整合了绝大部分的模块，而Eigen模块更是整合了所有模块（也就是整个Eigen库）。

![equation](.markdown.images/equation.svg)

#### 基本使用 - 建立矩阵

在Eigen中，所有的矩阵Matrix和向量Vector都是由Matrix类构造的。

Matrix模板类有6个参数，其中前三个参数是必须的

* Matrix<typename Scalar,int RowsAtCompileTime,int ColsAtCompileTime >
  * Scalar 是 标量类型，取值可以是 float ,int double 等。
  * RowsAtCompileTime 和 ColsAtCompileTime 是在程序编译时就已经知道的矩阵的行数和列数。
  * 定义好的类型: typedef Matrix<float,4,4> Matrix4f .

在Eigen中，列向量是默认向量，在不特别说明的情况下，向量Vector就是指的列向量。

* 列向量：typedef Matrix<float,3,1> Vector3f ;
* 行向量：typedef Matrix<int ,1,2 > RowVector2i ;

Eigen提供了定义动态大小的方法

* typedef Matrix<double ,Dynamic,Dynamic > MatrixXd;  
  * MatrixXd定义了任意行数和列数的矩阵

Eigen支持对动态大小的矩阵和向量重新指定大小。

* rows() , cols() , size() 分别返回行数，列数和 元素的个数。

* resize() 则可以重新指定矩阵大小。

```c++
#include <iostream>
#include <Eigen/Dense>
using namespace std;
using Eigen::MatrixXd;
int main()
{
  MatrixXd m(2,2);//MatrixXd表示是任意尺寸的矩阵ixj, m(2,2)代表一个2x2的方块矩阵
  m(0,0) = 3;//代表矩阵元素a11
  m(1,0) = 2.5;//a21
  m(0,1) = -1;//a12
  m(1,1) = m(1,0) + m(0,1);//a22=a21+a12
  cout << m << endl;//输出矩阵m
}

```

#### 基本使用 - 四则运算

###### 加减法

```c++
#include <iostream>
#include <Eigen/Dense>
using namespace std;
using namespace Eigen;
int main()
{
  Matrix2d a;
  a << 1, 2,
       3, 4;
  MatrixXd b(2,2);
  b << 2, 3,
       1, 4;
  cout << "a + b =\n" << a + b << endl;//矩阵加法
  cout << "a - b =\n" << a - b << endl;//矩阵减法
  cout << "Doing a += b;" << endl;
  a += b;//a = a + b，同时重新赋值a
  cout << "Now a =\n" << a << endl;
  Vector3d v(1,2,3);
  Vector3d w(1,0,0);
  cout << "-v + w - v =\n" << -v + w - v << endl;//向量加减法
}

```

###### **数乘**

```c++
#include <iostream>
#include <Eigen/Dense>
using namespace std;
using namespace Eigen;
int main()
{
  Matrix2d a;
  a << 1, 2,
       3, 4;
  Vector3d v(1,2,3);
  cout << "a * 2.5 =\n" << a * 2.5 << endl;//矩阵数乘
  cout << "0.1 * v =\n" << 0.1 * v << endl;//向量数乘
  cout << "Doing v *= 2;" << endl;
  v *= 2;//向量数乘，从新赋值v
  cout << "Now v =\n" << v << endl;
}

```

###### 转置矩阵**(![[公式]](.markdown.images/equation-1595345639559.svg) )**，共轭矩阵**( ![[公式]](.markdown.images/equation-1595345639548.svg) 或 ![[公式]](.markdown.images/equation-1595345639546.svg) )**，逆矩阵( ![[公式]](.markdown.images/equation-1595345639561.svg) )

```c++
#include <iostream>
#include <Eigen/Dense>
using namespace std;
using namespace Eigen;
int main()
{
  MatrixXcf a = MatrixXcf::Random(2,2);//定义2-by-2随机矩阵
  cout << "Here is the matrix a\n" << a << endl;//矩阵a
  cout << "Here is the matrix a^T\n" << a.transpose() << endl;//a的转置
  cout << "Here is the matrix a^H\n" << a.conjugate() << endl;//a的共轭
  cout << "Here is the matrix a^{-1}\n" << a.inverse() << endl;//a的逆
}
```

###### 矩阵&向量乘法

```c++
#include <iostream>
#include <Eigen/Dense>
using namespace std;
using namespace Eigen;
int main()
{
  Matrix2d m;
  m << 1, 2,
         3, 4;
  Vector2d u(-1,1), v(2,0);
  cout << "Here is m*m:\n" << m*m << endl;//矩阵-矩阵
  cout << "Here is m*u:\n" << m*u << endl;//矩阵-向量
  cout << "Here is u^T*m:\n" << u.transpose()*m << endl;//向量-矩阵
  cout << "Here is u^T*v:\n" << u.transpose()*v << endl;//向量-向量
  cout << "Here is u*v^T:\n" << u*v.transpose() << endl;//向量-向量
  cout << "Let's multiply m by itself" << endl;
  m = m*m;//矩阵-矩阵
  cout << "Now m is:\n" << m << endl;
}

```

###### 点乘&叉乘

```c++
#include <iostream>
#include <Eigen/Dense>
using namespace std;
using namespace Eigen;
int main()
{
  Vector3d v(1,2,3);
  Vector3d w(0,1,2);
  cout << "Dot product: " << v.dot(w) << endl;//向量点乘
  cout << "Cross product:\n" << v.cross(w) << endl;//向量叉乘
}
```

###### 其他 - 行列式、元素之和\积\平均数、最小\大元素、迹

```c++
#include <iostream>
#include <Eigen/Dense>
using namespace Eigen;
using namespace std;
int main()
{
  Matrix3d m;
  m   << 1, 2, 3,
         1, 2, 1,
	 0, 2, 4;
  cout << "Here is m.determinant():   " << m.determinant() << endl;// 行列式
  cout << "Here is m.sum():           " << m.sum() << endl;//所有元素之和
  cout << "Here is m.prod():          " << m.prod() << endl;//所有元素之积
  cout << "Here is m.mean():          " << m.mean() << endl;//元素的平均数
  cout << "Here is m.minCoeff():      " << m.minCoeff() << endl;//最小元素
  cout << "Here is m.maxCoeff():      " << m.maxCoeff() << endl;//最大元素
  cout << "Here is m.trace():         " << m.trace() << endl;//迹
//""里的空格可以让输出结果对齐
}
```

```c++
//结果：
Here is m.determinant():   4
Here is m.sum():           16
Here is m.prod():          0
Here is m.mean():          1.77778
Here is m.minCoeff():      0
Here is m.maxCoeff():      4
Here is m.trace():         7
```

#### 参考资料

[Eigen学习笔记2-Matrix类](https://www.cnblogs.com/wangxiaoyong/p/8903505.html)

[鸽子的学习笔记](https://zhuanlan.zhihu.com/pigeonnote)