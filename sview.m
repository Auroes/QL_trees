% Monte-Carlo ray tracing:sub-function
% 求方向向量,可批量处理

function sv = sview(szap,sazi)

% sv       方向向量

% szap     天顶角 (角度)
% sazi     方位角 (角度在[0,360))

szap=szap*pi/180;
sazi=sazi*pi/180;

size_szap=size(szap);
sv=zeros(size_szap(1),3);

pos1=find(sazi>=0 & sazi<pi/2);
if isempty(pos1)~=1
    sv(pos1,:)=[-sin(szap(pos1,:)).*cos(sazi(pos1,:)) -sin(szap(pos1,:)).*sin(sazi(pos1,:)) -cos(szap(pos1,:))];
end

pos2=find(sazi>=pi/2 & sazi<pi);
if isempty(pos2)~=1
    sv(pos2,:)=[sin(szap(pos2,:)).*cos(pi-sazi(pos2,:)) -sin(szap(pos2,:)).*sin(pi-sazi(pos2,:)) -cos(szap(pos2,:))];
end

pos3=find(sazi>=pi & sazi<pi*3/2);
if isempty(pos3)~=1
    sv(pos3,:)=[sin(szap(pos3,:)).*cos(sazi(pos3,:)-pi) sin(szap(pos3,:)).*sin(sazi(pos3,:)-pi) -cos(szap(pos3,:))];
end

pos4=find(sazi>=pi*3/2 & sazi<pi*2);
if isempty(pos4)~=1
    sv(pos4,:)=[-sin(szap(pos4,:)).*cos(2*pi-sazi(pos4,:)) sin(szap(pos4,:)).*sin(2*pi-sazi(pos4,:)) -cos(szap(pos4,:))];
end

% if sazi>=0 && sazi<pi/2
%     sv=[-sin(szap).*cos(sazi) -sin(szap).*sin(sazi) -cos(szap)];
% end
%
% if sazi>=pi/2 && sazi<pi
%     sv=[sin(szap).*cos(pi-sazi) -sin(szap).*sin(pi-sazi) -cos(szap)];
% end
%
% if sazi>=pi && sazi<pi*3/2
%     sv=[sin(szap).*cos(sazi-pi) sin(szap).*sin(sazi-pi) -cos(szap)];
% end
%
% if sazi>=pi*3/2 && sazi<pi*2
%     sv=[-sin(szap).*cos(2*pi-sazi) sin(szap).*sin(2*pi-sazi) -cos(szap)];
% end
%
% quiver3(0,0,0,sv(1,1),sv(1,2),sv(1,3),1); % 画箭头图
% grid on
% axis equal
