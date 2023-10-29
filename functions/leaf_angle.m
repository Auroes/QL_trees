% Monte-Carlo ray tracing:sub-function
% 产生叶片的角度数据
function [f_theta_L, nnr] = leaf_angle(f_theta,num)

% f_theta_L            以1度为间隔，某种类型叶倾角分布在具体某个叶倾角上的实际概率 (%)
% nnr                  叶片中心点法向量

% f_theta              叶倾角分布代码：1 Erectophile 喜直型; 2 Planophile 喜平型; 3 Plagiophile 倾斜型; 4 Spherical 球面型; 5 Uniform 均匀型; 6 自定义叶倾角分布，读入累积概率密度分布
% num                  叶片数量

%% 计算各种叶倾角的概率
theta_L=0:90; % 叶倾角在0~90间
if f_theta==1
    f_theta_L(1,:)=(2*theta_L*pi/180-sin(2*theta_L*pi/180))/pi; % 累计概率密度分布
end
if f_theta==2
    f_theta_L(1,:)=(2*theta_L*pi/180+sin(2*theta_L*pi/180))/pi; % 累计概率密度分布
end
if f_theta==3
    f_theta_L(1,:)=(2*theta_L*pi/180-0.5*sin(4*theta_L*pi/180))/pi; % 累计概率密度分布
end
if f_theta==4
    f_theta_L(1,:)=1-cos(theta_L*pi/180); % 累计概率密度分布
end
if f_theta==5
    f_theta_L(1,:)=2/pi*(theta_L*pi/180); % 累计概率密度分布
end
if f_theta==6
    readdata=strcat('.\Model_input\leafangledistributionacc.mat'); % 读入文件
    pp = load(readdata);
    f_theta_L=pp.leafangledistribution;
end

% 将累计概率密度分布转换成某种类型叶倾角分布在具体某个叶倾角上的实际概率,即概率分布的离散化
tp=[0,f_theta_L];
for i=2:92 % 以1度为间隔，某种类型叶倾角分布在具体某个叶倾角上的实际概率
    f_theta_L(1,i)=tp(:,i)-tp(:,i-1);
end
f_theta_L=f_theta_L(2:end);

%% 叶片中心点法向量
% 叶片天顶角分配 20220126
nnr_zenith_num=fix(num.*f_theta_L); % 0-90度叶倾角各自的叶片数量
num_rest=num-sum(nnr_zenith_num); % 取整后剩余的叶片数量
nnr_zenith_num(1:num_rest)=nnr_zenith_num(1:num_rest)+1; % 将剩余叶片数量补充到叶倾角中

nnr_zenith=[];
nnr_azimuth=[];
for i=0:90 % 循环角度给每个叶片赋叶倾角和方位角,角度
    nnr_zenith=[nnr_zenith; repmat(i,nnr_zenith_num(i+1),1)]; % n*1
    
    jg=360/nnr_zenith_num(i+1);
    tmp=0:jg:359;
    if nnr_zenith_num(i+1)~=0
        nnr_azimuth=[nnr_azimuth; tmp']; % 给每个叶片赋方位角,角度
    end
    size_tmp=size(tmp);
    dif=nnr_zenith_num(i+1)-size_tmp(2); % 方位角不能恰好匹配的情况
    if dif>0
        nnr_azimuth=[nnr_azimuth; zeros(dif,1)+359.5];
    end
end

% for i=1:num % 循环叶片数量
%     nnr(i,:)=-sview(nnr_zenith(i,:),nnr_azimuth(i,:)); % 用计算太阳法向量的代码，根据角度计算法向量
% end

nnr = -sview(nnr_zenith,nnr_azimuth); % 用计算太阳法向量的代码，根据角度计算法向量

