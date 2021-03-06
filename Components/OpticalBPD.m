classdef OpticalBPD < Optical_ & ActiveModule
    %OpticalBPD v1.0, Lingchen Huang, 2015/4/14
    % This module is usually used in coherent detection or differencial
    % phase detection. Two optical photo detectors are employed and the
    % PD output electrical fields do subtraction to obtain the output.
    
    properties
        OverlapRatio
        Responsivity
        Bandwidth
        LPF
        AddNoise
        BufferLength
    end
    properties (SetAccess = private)
        PIN1
        PIN2
    end
    methods
        function obj = OpticalBPD(varargin)
            SetVariousProp(obj, varargin{:})
            Init(obj)
        end
        function Init(obj)
            obj.PIN1 = OpticalPD('OverlapRatio', obj.OverlapRatio,...
                'Responsivity', obj.Responsivity, ...
                'Bandwidth', obj.Bandwidth, ...
                'LPF', obj.LPF, ...
                'AddNoise', obj.AddNoise, ...
                'BufferLength', obj.BufferLength);
            obj.PIN2 = OpticalPD('OverlapRatio', obj.OverlapRatio,...
                'Responsivity', obj.Responsivity, ...
                'Bandwidth', obj.Bandwidth, ...
                'LPF', obj.LPF, ...
                'AddNoise', obj.AddNoise, ...
                'BufferLength', obj.BufferLength);
        end
        function Reset(obj)
            Reset(obj.PIN1);
            Reset(obj.PIN2);
        end
        function y = Processing(obj, x)
            V1 = obj.PIN1.Processing( x{1} );
            V2 = obj.PIN2.Processing( x{2} );
            y = EleSub(V1{1},V2{1});
        end
    end
    
end