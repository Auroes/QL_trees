classdef Lucem < handle
    %LUCEM 光线超类
    %   此处显示详细说明
    
    properties
        O % 初始坐标
        D % 方向向量
    end
    
    methods
        function obj = Lucem(O,D) % 构造光线 P(t)=O+D*t
            obj.O = O;
            obj.D = D;
        end
        
        function [] = getCoordinate(t) % 获取t时间后的坐标
            O+D*t;
        end
    end
end