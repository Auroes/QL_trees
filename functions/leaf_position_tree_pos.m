% ��������z�������
function tree_pos = leaf_position_tree_pos(sn,pos,edge) %����ķ����� ���������������е�xyz���� �����������߳�(��ֱ��)

% �������Ĺ�(0,0,0)ʱ����4�ǵ��xyz����
pCorner = squareCorner(sn,edge);

% 4���ǵ��z������Сֵ��Ϊ�������������ľ���
[min_z, pos_min_z]=min(pCorner(:,3)); %min����������Сֵ�Լ���Ӧ���к� ��1��ʼ����

% �������ڵ�z����
z=-(sn(1)*(pos(:,1) - pCorner(pos_min_z,1)) + sn(2)*(pos(:,2) - pCorner(pos_min_z,2)))/sn(3);
pos(:,3)=z; % z���긳���������pos�е�z����
tree_pos=pos; % ���º��pos��Ϊ������tree_pos���� �����������ϵ�xyz����