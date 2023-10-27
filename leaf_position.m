% ��������λ�ò�������(������)��������ҶƬλ��
% [center,maxH,minH,shadow,square]=leaf_position(0,0,'canopy_L9.mat');

function leaf_position(za,zi,canopy_para) % ���� �����¶� �¶ȵķ�λ�� ������ÿ�����Ĳ�������

% center      �ڲ���ÿ��ҶƬ���������꣬���ʱ��(0,0)Ϊ���ص�xy��������
% maxH        �ڲ�����ߵ�һ�����ĸ߶�
% minH        �ڲ�����͵�֦�¸�
% shadow      ����ҶƬͶӰ���,��λ��m2,����ҶƬ��Բ�λ�����
% square      ������Ԫ���(��ֱͶӰ���)

% za          ������¶ȣ�����Ƕ�
% zi          �¶ȵķ�λ�ǣ�����Ƕ�
% canopy_para ������ÿ�����Ĳ����ľ���,e.g. canopy_L1.mat

% ����������ÿ�����Ĳ����ľ���canopy_para,ÿ��Ĳ����ɲ�ͬ
% 1 ��� ��            1      2    ...  n ��  ����ľ����һ������ſ�ͷ��˵��ÿһ����һ�����Ĳ���
% 2 ��������x          x      x    ...  x     ��λ��m ���뷶Χ[0,��)
% 3 ��������y          x      x    ...  x     ��λ��m ���뷶Χ[0,��)
% 4 ������״           x      x    ...  x     1��Ͳ�� Cylinder; 2��׶�� Cone; 3�� ׶+Ͳ �� Cone+Cylinder; 4����������� Sphere/Ellipsiod
% 5 ҶƬ����           x      x    ...  x     ��͵��ڹڲ���Ҫ����ҶƬ����,������������ҶƬ���͸�����ÿ������ҶƬ������ͬ�����ҶƬƽ���ֵ�����������
% 6 ���ڰ뾶r          x      x    ...  x     ��λ��m
% 7 ֦�¸�ha           x      x    ...  x     ��λ��m
% 8 Ͳ��  hb           x      x    ...  x     ��λ��m
% 9 �ڶ����alpha      x      x    ...  x     ��λ���Ƕ�
% 10����ҶƬͶӰ���    x      x    ...  x     ��λ��m^2,����ҶƬ��Բ�λ�����
% 11�������������      x      x    ...  x     ��λ��m^2

%% �����������
tmp=strcat('.\Model_input\',canopy_para); % �����ļ�·���ַ���tmp�����ļ�·��ָ��Ϊ��ǰĿ¼�µ�Model_input�ļ��У�����canopy_para��Ϊ�ļ���
canopy_para = load(tmp); % ����canopy_para��MAT�ļ� �����ݴ洢��canopy_para������ load�������ڼ���MAT�ļ������������ݸ���ָ���ı�����
canopy_para=canopy_para.canopy_para;

% ��canopy_para��������ȡ���������� ����ҶƬͶӰ��� ��Ԫ���
shadow = canopy_para(10,1);
square = canopy_para(11,1);

% ��������ҶƬ����֮��
num = sum(canopy_para(5,:));

% ��������Ԫ�߳�
edge = square^0.5; 

% ���ÿ������xy�����Ƿ��������� �������ڱ߳�
tmp_find = find(canopy_para(2,:)>edge | canopy_para(3,:)>edge); %#ok<EFIND>
if isempty(tmp_find)~=1
    msgbox('Error input in plot_leaf! code 1'); % ���겻�������� ����һ��������Ϣ��
end

% ����������ÿ���������ɵײ����� ��(0,0)Ϊ���ص�xy��������
canopy_para(2,:)=canopy_para(2,:)-edge/2;
canopy_para(3,:)=canopy_para(3,:)-edge/2;

% ���ҶƬ�����Ƿ���ȷ
size_crown=size(canopy_para); % ����canopy_para����Ĵ�С
leaf_c=sum(canopy_para(5,:)); % ����ҶƬ������
if leaf_c~=num % ������������ҶƬ���͸�����ÿ������ҶƬ������ͬ�����ҶƬƽ���ֵ�����������
    canopy_para(5,1:(size_crown(2)-1))=fix(num/size_crown(2));
    canopy_para(5,size_crown(2))=num-fix(num/size_crown(2))*(size_crown(2)-1);
    msgbox('Error input in plot_leaf! code 2');
end

sn = -sview(za,zi); % sview ��һ��δ����ĺ��� ��ȡ���淨����
center = []; 
for i=1:size_crown(2) % ѭ��ÿ������
    
    % ���ɰ뾶Ϊr�����ھ��ȷֲ����ݵ� ref:https://wenku.baidu.com/view/2a4bda55f142336c1eb91a37f111f18583d00cd8.html?_wkts_=1688288190053&bdQuery=%E5%9C%A8%E4%B8%80%E4%B8%AA%E7%90%83%E5%86%85%E5%9D%87%E5%8C%80%E5%88%86%E5%B8%83%E7%9A%84%E7%82%B9+matlab
    angle1=rand(1,canopy_para(5,i))*2*pi;
    angle2=acos(rand(1,canopy_para(5,i))*2-1);
    r=power(rand(1,canopy_para(5,i)),1/3).*canopy_para(6,i);
    x=r.*cos(angle1).*sin(angle2);
    y=r.*sin(angle1).*sin(angle2);
    z=r.*cos(angle2);
    %     figure
    %     plot3(x,y,z,'r.');
    %     axis square

    pos=[canopy_para(2,i),canopy_para(3,i),0]; % ����ĵ�i�������������������е�xyz����
    tree_pos=leaf_position_z_height(sn,pos,edge); % ÿ���������������ϵ�xyz����
    lc=[x',y',z']; % crown_leaf_center(canopy_para(5,i),canopy_para(6,i),canopy_para(7,i),canopy_para(8,i),canopy_para(9,i),canopy_para(4,i)); % ��i��������ҶƬ��[0,0,0]Ϊ��׼��ҶƬλ��
    lc_new=[lc(:,1)+tree_pos(:,1) lc(:,2)+tree_pos(:,2) lc(:,3)+tree_pos(:,3)+canopy_para(7,i)+0.5*canopy_para(8,i)];
    center=[center;lc_new]; % ��һ��������ҶƬ���ĵ�����ӵ��ڲ���
    
end

% plot3(coord(:,1),coord(:,2),coord(:,3),'ko')
% axis equal
% grid on

%% �ҵ��ڲ�����ߵ�һ�����ĸ߶�
maxh=max(canopy_para(7,:)+canopy_para(8,:));

%% �ҵ��ڲ�����͵�֦�¸�
minh=min(canopy_para(7,:));

%% ������!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
save('crown_L3_leafmat.mat','center','maxh','minh','shadow','square');
