function pCorner = squareCorner(sn,edge)
%CORNER 此处显示有关此函数的摘要
%   此处显示详细说明
% 坡面中心过(0,0,0)时样地4角点的xyz坐标
pCorner=[[ edge/2, edge/2,-(sn(1)*( edge/2) +sn(2)*( edge/2))/sn(3)];...
         [-edge/2, edge/2,-(sn(1)*(-edge/2) +sn(2)*( edge/2))/sn(3)];...
         [ edge/2,-edge/2,-(sn(1)*( edge/2) +sn(2)*(-edge/2))/sn(3)];...
         [-edge/2,-edge/2,-(sn(1)*(-edge/2) +sn(2)*(-edge/2))/sn(3)]];
pCorner;
end

