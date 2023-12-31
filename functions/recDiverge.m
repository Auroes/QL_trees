%recDiverge 发散递归函数
function unitData = recDiverge(lucem,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData)
    
    % 碰撞检测 返回是否碰撞 碰撞坐标
    [x,newO] = Hit(lucem,leaf_r,center,nnr);

    % 未发生碰撞  返回深度为1的unitData
    if  x == 0
        unitData(indexDeep,1) = unitData(indexDeep,1) + 0;

    % 发生碰撞 发散光线数为8
    elseif x == 1 && diverN == 8
        % 当前深度 碰撞光线加1
        unitData(indexDeep,1) = unitData(indexDeep,1) + 1;
        % 产生下一深度
        indexDeep = indexDeep + 1;
            % 如果下一深度为最大深度 无需再对8条子光线碰撞检测 直接返回
            if indexDeep == maxN
                unitData;
                return;
            end

        % 生成8条子光线
        lucem1 = Lucem(newO,[0.5774 0.5774 0.5774]);
        unitData = recDiverge(lucem1,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);

        lucem2 = Lucem(newO,[-0.5774 0.5774 0.5774]);
        unitData = recDiverge(lucem2,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);

        lucem3 = Lucem(newO,[0.5774 -0.5774 0.5774]);
        unitData = recDiverge(lucem3,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);

        lucem4 = Lucem(newO,[0.5774 0.5774 -0.5774]);
        unitData = recDiverge(lucem4,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);

        lucem5 = Lucem(newO,[-0.5774 -0.5774 0.5774]);
        unitData = recDiverge(lucem5,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);

        lucem6 = Lucem(newO,[-0.5774 0.5774 -0.5774]);
        unitData = recDiverge(lucem6,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);

        lucem7 = Lucem(newO,[0.5774 -0.5774 -0.5774]);
        unitData = recDiverge(lucem7,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);

        lucem8 = Lucem(newO,[-0.5774 -0.5774 -0.5774]);
        unitData = recDiverge(lucem8,leaf_r,maxN,center,diverN,nnr,indexDeep,unitData);
    end
end