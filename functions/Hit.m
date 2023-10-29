%HIT 碰撞检测函数
function [ture,newO]  = Hit(lucem,leaf_r,center,nnr)

    % 遍历每一片叶子
    matrixSize = size(center);
    % 距离指针
    indexT = inf; % 初始碰撞点距离光源点无穷远

    for i = 1 : matrixSize(2)
        % 叶片平面 光线方程量
        A0 = center(i,1);
        B0 = center(i,2);
        C0 = center(i,3);
        A = nnr(i,1);
        B = nnr(i,2);
        C = nnr(i,3);
        D = -(A*A0 + B*B0 + C*C0);
        P0 = lucem.O; % 光线原点
        V  = lucem.D; % 光线方向向量

        if [A,B,C]*D == 0
            ture = 0; % 叶片与光线平行 不发生碰撞

        else
            t = -(A*P0(1) + B*P0(2) + C*P0(3) + D)/(A*V(1) + B*V(2) + C*V(3)); % 计算t值
            if t <= 0 
                ture = 0; % 叶片在光线反向 不发生碰撞
            else
            hitPoint = P0 + V*t; % 碰撞点坐标
            distance = sqrt((Bx - Ax)^2 + (By - Ay)^2 + (Bz - Az)^2); % 碰撞点到叶心的距离
                if distance > leaf_r
                    ture = 0; % 叶片在光线之外 不发生碰撞
                else % 发生碰撞
                    if distance < indexT % 筛选更近的碰撞叶片
                    indexT = distance; % 距离指针置为光源点到本次碰撞点距离
                    end
                end
            end
        end
    end
ture = 1; % 发生碰撞
newO = hitPoint; % 返回距离光源最近的碰撞点坐标
end