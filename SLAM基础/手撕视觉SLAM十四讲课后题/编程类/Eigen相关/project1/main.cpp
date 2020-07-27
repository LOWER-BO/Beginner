// Eigen 几何模块
#include <iostream>
#include "Eigen/Dense"
using namespace std;
using namespace Eigen;

int main(){
        MatrixXf m(4,4);
        m<< 1,2,3,4,
        5,6,7,8,
        9,10,11,12,
        13,14,15,16;

        cout<<m.block<0,0>(3,3)<<endl<<endl;
        return 1;
}