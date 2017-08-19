classdef OpAmp < Component
  properties
    outPoint
  end
  methods
    function obj = OpAmp(name,source,sink,outPoint)
      obj@Component(name,source,sink);
      obj.outPoint = outPoint;
    end
    function adding(obj,index)
      global circuitM solutionM knownM opAmp;
      [m,n] = size(circuitM);
      circuitM(obj.outPoint,n+1) = 1;
      circuitM(m+1,obj.source) = 1;
      circuitM(m+1,obj.sink) = -1;
      solutionM(n+1,1) = 0;
      knownM(m+1,1) = 0;
      opAmp{index}.solutionIndex = n+1;
    end
    function vol = getVoltage(obj)
      global solutionM;
      vol = solutionM(obj.outPoint);
    end
  end
end
