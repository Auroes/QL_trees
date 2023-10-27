classdef Leaf < headle
    %LEAF 对叶建模
    %   超类 继承圆形和球形叶 子类
    
    properties
        coord %叶片中心坐标
        r     %叶半径
        n     %法向量
    end
    
    methods
        function obj = Leaf(coord,r,n)
            obj.coord = coord;
            obj.coord = r;
            obj.n = n;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            outputArg = obj.Property1 + inputArg;
        end
    end
end

