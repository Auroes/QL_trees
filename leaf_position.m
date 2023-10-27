% 根据树冠位置产生样方(含坡面)所有树的叶片位置
% [center,maxH,minH,shadow,square]=leaf_position(0,0,'canopy_L9.mat');

function leaf_position(za,zi,canopy_para) % 输入 坡面坡度 坡度的方位角 样地中每株树的参数矩阵

% center      冠层中每个叶片的中心坐标，输出时以(0,0)为样地的xy坐标中心
% maxH        冠层中最高的一棵树的高度
% minH        冠层中最低的枝下高
% shadow      单个叶片投影面积,单位：m2,假设叶片是圆形或球形
% square      区域像元面积(垂直投影面积)

% za          坡面的坡度，输入角度
% zi          坡度的方位角，输入角度
% canopy_para 样地中每株树的参数的矩阵,e.g. canopy_L1.mat

% 保存样地中每株树的参数的矩阵canopy_para,每株的参数可不同
% 1 序号 第            1      2    ...  n 株  输入的矩阵第一行以序号开头，说明每一列是一株树的参数
% 2 树根坐标x          x      x    ...  x     单位：m 输入范围[0,∞)
% 3 树根坐标y          x      x    ...  x     单位：m 输入范围[0,∞)
% 4 树冠形状           x      x    ...  x     1是筒形 Cylinder; 2是锥形 Cone; 3是 锥+筒 形 Cone+Cylinder; 4是球或椭球体 Sphere/Ellipsiod
% 5 叶片数量           x      x    ...  x     求和等于冠层需要产生叶片数量,如果计算出来的叶片数和给定的每棵树的叶片数量不同，则把叶片平均分到所有树冠上
% 6 树冠半径r          x      x    ...  x     单位：m
% 7 枝下高ha           x      x    ...  x     单位：m
% 8 筒高  hb           x      x    ...  x     单位：m
% 9 冠顶半角alpha      x      x    ...  x     单位：角度
% 10单个叶片投影面积    x      x    ...  x     单位：m^2,假设叶片是圆形或球形
% 11正方形样地面积      x      x    ...  x     单位：m^2

%% 读入参数矩阵
tmp=strcat('.\Model_input\',canopy_para); % 构建文件路径字符串tmp，将文件路径指定为当前目录下的Model_input文件夹，附加canopy_para作为文件名
canopy_para = load(tmp); % 加载canopy_para的MAT文件 将内容存储在canopy_para变量中 load函数用于加载MAT文件，并将其内容赋给指定的变量。
canopy_para=canopy_para.canopy_para;

% 从canopy_para矩阵中提取了两个参数 单个叶片投影面积 像元面积
shadow = canopy_para(10,1);
square = canopy_para(11,1);

% 所有树的叶片数量之和
num = sum(canopy_para(5,:));

% 正方形像元边长
edge = square^0.5; 

% 检查每棵树的xy坐标是否都在样地内 均不大于边长
tmp_find = find(canopy_para(2,:)>edge | canopy_para(3,:)>edge); %#ok<EFIND>
if isempty(tmp_find)~=1
    msgbox('Error input in plot_leaf! code 1'); % 坐标不在样地内 弹出一个错误消息框
end

% 调整样地中每棵树的树干底部坐标 以(0,0)为样地的xy坐标中心
canopy_para(2,:)=canopy_para(2,:)-edge/2;
canopy_para(3,:)=canopy_para(3,:)-edge/2;

% 检查叶片总数是否正确
size_crown=size(canopy_para); % 计算canopy_para矩阵的大小
leaf_c=sum(canopy_para(5,:)); % 计算叶片的总数
if leaf_c~=num % 如果计算出来的叶片数和给定的每棵树的叶片数量不同，则把叶片平均分到所有树冠上
    canopy_para(5,1:(size_crown(2)-1))=fix(num/size_crown(2));
    canopy_para(5,size_crown(2))=num-fix(num/size_crown(2))*(size_crown(2)-1);
    msgbox('Error input in plot_leaf! code 2');
end

sn = -sview(za,zi); % sview 是一个未定义的函数 获取坡面法向量
center = []; 
for i=1:size_crown(2) % 循环每个树冠
    
    % 生成半径为r的球内均匀分布数据点 ref:https://wenku.baidu.com/view/2a4bda55f142336c1eb91a37f111f18583d00cd8.html?_wkts_=1688288190053&bdQuery=%E5%9C%A8%E4%B8%80%E4%B8%AA%E7%90%83%E5%86%85%E5%9D%87%E5%8C%80%E5%88%86%E5%B8%83%E7%9A%84%E7%82%B9+matlab
    angle1=rand(1,canopy_para(5,i))*2*pi;
    angle2=acos(rand(1,canopy_para(5,i))*2-1);
    r=power(rand(1,canopy_para(5,i)),1/3).*canopy_para(6,i);
    x=r.*cos(angle1).*sin(angle2);
    y=r.*sin(angle1).*sin(angle2);
    z=r.*cos(angle2);
    %     figure
    %     plot3(x,y,z,'r.');
    %     axis square

    pos=[canopy_para(2,i),canopy_para(3,i),0]; % 读入的第i棵树树冠中心在样地中的xyz坐标
    tree_pos=leaf_position_z_height(sn,pos,edge); % 每棵树树根在坡面上的xyz坐标
    lc=[x',y',z']; % crown_leaf_center(canopy_para(5,i),canopy_para(6,i),canopy_para(7,i),canopy_para(8,i),canopy_para(9,i),canopy_para(4,i)); % 第i棵树所有叶片以[0,0,0]为标准的叶片位置
    lc_new=[lc(:,1)+tree_pos(:,1) lc(:,2)+tree_pos(:,2) lc(:,3)+tree_pos(:,3)+canopy_para(7,i)+0.5*canopy_para(8,i)];
    center=[center;lc_new]; % 把一棵树所有叶片中心点坐标加到冠层中
    
end

% plot3(coord(:,1),coord(:,2),coord(:,3),'ko')
% axis equal
% grid on

%% 找到冠层中最高的一棵树的高度
maxh=max(canopy_para(7,:)+canopy_para(8,:));

%% 找到冠层中最低的枝下高
minh=min(canopy_para(7,:));

%% 保存结果!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
save('crown_L3_leafmat.mat','center','maxh','minh','shadow','square');
