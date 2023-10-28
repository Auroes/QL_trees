% 计算树的z坐标程序
function tree_pos = leaf_position_tree_pos(sn,pos,edge) %坡面的法向量 树冠中心在样地中的xyz坐标 正方形样方边长(垂直视)

% 坡面中心过(0,0,0)时样地4角点的xyz坐标
pCorner = squareCorner(sn,edge);

% 4个角点的z坐标最小值作为整个坡面上升的距离
[min_z, pos_min_z]=min(pCorner(:,3)); %min函数返回最小值以及对应的行号 从1开始计数

% 树根所在的z坐标
z=-(sn(1)*(pos(:,1) - pCorner(pos_min_z,1)) + sn(2)*(pos(:,2) - pCorner(pos_min_z,2)))/sn(3);
pos(:,3)=z; % z坐标赋给输入参数pos中的z坐标
tree_pos=pos; % 更新后的pos作为输出结果tree_pos返回 树根在坡面上的xyz坐标