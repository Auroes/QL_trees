%HIT 碰撞检测函数
function [x,newO]  = Hit(lucem,leaf_r,center,nnr)
    x = 0; % 初始化为没有碰撞
    indexT = inf; % 距离指针 初始碰撞点距离光源点无穷远
    hitPoint = zeros(1, 3); % 记录最近的碰撞点
    newO = zeros(1, 3); % 返回的新反射点

    for i = 1 :size(center,1)
        % 叶片平面
        A0 = center(i,1);
        B0 = center(i,2);
        C0 = center(i,3);
        A  = nnr(i,1);
        B  = nnr(i,2);
        C  = nnr(i,3);
        % 光线方程
        P0 = lucem.O; % 光线原点
        V  = lucem.D; % 光线方向向量

        if A*V(1)+B*V(2)+C*V(3) == 0  % 叶片与光线平行 不发生碰撞
            continue;
        else
            t = ((A0-P0(1))*A + (B0-P0(2))*B + (C0-P0(3))*C)/(A*V(1) + B*V(2) + C*V(3)); % 计算t值
            if t <= 0 % 叶片在光线反向 不发生碰撞
                continue;
            else % 光线碰撞叶所在平面
                hitPoint = P0 + V*t; % 碰撞点坐标
                distance = sqrt((A0 - hitPoint(1))^2 + (B0 - hitPoint(2))^2 + (C0 - hitPoint(3))^2); % 碰撞点到叶心的距离
                if distance > leaf_r % 叶片在光线之外 不发生碰撞
                    continue;
                elseif t < 0.000001 % 舍去过于靠近的值 避免穿模
                    continue;
                elseif t >= indexT % 筛选更近的碰撞叶片
                    continue;
                else   % 光线真的碰撞叶片了！
                        indexT = t; % 距离指针置为光源点到本次碰撞点距离
                        x = 1; % 发生碰撞
                        newO = hitPoint; % 返回距离光源最近的碰撞点坐标
                end
            end
        end
    end
end