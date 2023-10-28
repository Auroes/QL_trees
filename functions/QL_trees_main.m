%QL_TREES_MAIN 林叶光线追踪主函数
function [P,n] = QL_trees_main(za,zi,canopy_para,leaf_r,dense,D,maxN)
%   输入参数 坡度za 方位角zi 树林模型文件名canopy_para 叶半径leaf_r 光线密度dense(0-1] 光线方向向量D 最大碰撞次数maxN
%   返回 概率P(n) n∈[1,maxN]

% 读入参数
[center,edge] = leaf_position(za,zi,canopy_para); % 导出叶坐标 样地四角坐标

% 光线追踪
for i = edge/2 :-dense :-edge/2
    for j = edge/2 :-dense :-edge/2
        lucem = Lucem([j,i],D);
        Hit(lucem,center,leaf_r,maxN)



    end
end














P = ;
n = ;
end

