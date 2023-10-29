%QL_TREES_MAIN 林叶光线追踪主函数
function answer42 = QL_trees_main(za,zi,canopy_para,leaf_r,dense,D,maxN,diverN,f_theta)
%   输入参数 坡度za 方位角zi 树林模型文件名canopy_para 叶半径leaf_r 光线密度dense∈(0-1] 光线方向向量D 最大碰撞次数maxN 光线发散数diverN 叶倾角分布nnr
%   返回 概率P(n) n∈[1,maxN]

    % 读入参数
    [center,edge,nnr] = leaf_position(za,zi,canopy_para,f_theta); % 导出叶坐标 样地尺寸 叶法向量
    
    % 中间数组 每行 对应深度 列1为碰撞总数hitN 列2为光线总数lucemN
    hitN_lucemN = [];
    % 结果数组 储存答案
    answer42 = [];

    % 光线追踪
    for i = edge/2 :-dense :-edge/2
        for j = edge/2 :-dense :-edge/2
            % 递归函数的深度指针 % 对于每条初始光线 将指针重置为1
            indexDeep = 1;
            % 按光线密度为步长遍历生成光线
            lucem = Lucem([j,i],D);
            % 对于每条(i,j)位置发射的光线 返回 每一深度 碰撞光线数量 的数组unitData
            unitData = recDiverge(lucem,leaf_r,maxN,center,diverN,nnr,indexDeep);

            % 遍历unitData数组的每一深度k 添加总数到中间数组
            for k = 1:maxN
                if k == 1
                    if unitData(1,1) == 0
                        hitN_lucemN(k,1) = hitN_lucemN(k,1) + 0;%初始光线未碰撞 总碰撞光线数加0
                        hitN_lucemN(k,2) = hitN_lucemN(k,2) + 1;%初始光线未碰撞 总光线数加1
                    else
                        hitN_lucemN(k,1) = hitN_lucemN(k,1) + 1;%初始光线碰撞 总碰撞光线数加1
                        hitN_lucemN(k,2) = hitN_lucemN(k,2) + 1;%初始光线碰撞 总光线数加1
                    end
                else % k >=2
                        hitN_lucemN(k,1) = hitN_lucemN(k,1) + hitN_lucemN(k-1,1) + unitData(k,1);%从深度2开始 总碰撞光线数累加
                        hitN_lucemN(k,2) = hitN_lucemN(k,2) + hitN_lucemN(k-1,1) + diverN*unitData(k-1,1);%从深度2开始 总光线数等于 上一深度总光线数 与光线发散数量乘以上一深度碰撞数 的累加
                end
            end
        end
    end
    
    for m = 1:maxN
        answer42(m,1) = m;
        answer42(m,2) = hitN_lucemN(m,1)/hitN_lucemN(m/2);
    end

    % 返回结果数组 列1为深度n∈[1,maxN] 列2为频数P∈(0,1)
    answer42;
end

