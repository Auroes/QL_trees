% Monte-Carlo ray tracing:sub-function
% ����ҶƬ�ĽǶ�����
function [f_theta_L, nnr] = leaf_angle(f_theta,num)

% f_theta_L            ��1��Ϊ�����ĳ������Ҷ��Ƿֲ��ھ���ĳ��Ҷ����ϵ�ʵ�ʸ��� (%)
% nnr                  ҶƬ���ĵ㷨����

% f_theta              Ҷ��Ƿֲ����룺1 Erectophile ϲֱ��; 2 Planophile ϲƽ��; 3 Plagiophile ��б��; 4 Spherical ������; 5 Uniform ������; 6 �Զ���Ҷ��Ƿֲ��������ۻ������ܶȷֲ�
% num                  ҶƬ����

%% �������Ҷ��ǵĸ���
theta_L=0:90; % Ҷ�����0~90��
if f_theta==1
    f_theta_L(1,:)=(2*theta_L*pi/180-sin(2*theta_L*pi/180))/pi; % �ۼƸ����ܶȷֲ�
end
if f_theta==2
    f_theta_L(1,:)=(2*theta_L*pi/180+sin(2*theta_L*pi/180))/pi; % �ۼƸ����ܶȷֲ�
end
if f_theta==3
    f_theta_L(1,:)=(2*theta_L*pi/180-0.5*sin(4*theta_L*pi/180))/pi; % �ۼƸ����ܶȷֲ�
end
if f_theta==4
    f_theta_L(1,:)=1-cos(theta_L*pi/180); % �ۼƸ����ܶȷֲ�
end
if f_theta==5
    f_theta_L(1,:)=2/pi*(theta_L*pi/180); % �ۼƸ����ܶȷֲ�
end
if f_theta==6
    readdata=strcat('.\Model_input\leafangledistributionacc.mat'); % �����ļ�
    pp = load(readdata);
    f_theta_L=pp.leafangledistribution;
end

% ���ۼƸ����ܶȷֲ�ת����ĳ������Ҷ��Ƿֲ��ھ���ĳ��Ҷ����ϵ�ʵ�ʸ���,�����ʷֲ�����ɢ��
tp=[0,f_theta_L];
for i=2:92 % ��1��Ϊ�����ĳ������Ҷ��Ƿֲ��ھ���ĳ��Ҷ����ϵ�ʵ�ʸ���
    f_theta_L(1,i)=tp(:,i)-tp(:,i-1);
end
f_theta_L=f_theta_L(2:end);

%% ҶƬ���ĵ㷨����
% ҶƬ�춥�Ƿ��� 20220126
nnr_zenith_num=fix(num.*f_theta_L); % 0-90��Ҷ��Ǹ��Ե�ҶƬ����
num_rest=num-sum(nnr_zenith_num); % ȡ����ʣ���ҶƬ����
nnr_zenith_num(1:num_rest)=nnr_zenith_num(1:num_rest)+1; % ��ʣ��ҶƬ�������䵽Ҷ�����

nnr_zenith=[];
nnr_azimuth=[];
for i=0:90 % ѭ���Ƕȸ�ÿ��ҶƬ��Ҷ��Ǻͷ�λ��,�Ƕ�
    nnr_zenith=[nnr_zenith; repmat(i,nnr_zenith_num(i+1),1)]; % n*1
    
    jg=360/nnr_zenith_num(i+1);
    tmp=0:jg:359;
    if nnr_zenith_num(i+1)~=0
        nnr_azimuth=[nnr_azimuth; tmp']; % ��ÿ��ҶƬ����λ��,�Ƕ�
    end
    size_tmp=size(tmp);
    dif=nnr_zenith_num(i+1)-size_tmp(2); % ��λ�ǲ���ǡ��ƥ������
    if dif>0
        nnr_azimuth=[nnr_azimuth; zeros(dif,1)+359.5];
    end
end

% for i=1:num % ѭ��ҶƬ����
%     nnr(i,:)=-sview(nnr_zenith(i,:),nnr_azimuth(i,:)); % �ü���̫���������Ĵ��룬���ݽǶȼ��㷨����
% end

nnr = -sview(nnr_zenith,nnr_azimuth); % �ü���̫���������Ĵ��룬���ݽǶȼ��㷨����

