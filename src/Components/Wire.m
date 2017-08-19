classdef Wire < Component
  properties
  end
  methods(Static)
    function obj = Wire(name,source,sink,current)
      obj@Component(name, source, sink);
      if ~isempty(current)
        obj.current = current;
      end
    end
    function fillCirM(obj,index)
      global circuitM knownM solutionM allComponent;
      [m,n] = size(circuitM);
      if isempty(obj.current)
        solutionM(n+1,1) = 0;
        allComponent{index}.solutionIndex = n+1;
        circuitM(obj.source,n+1) = 1;
        circuitM(obj.sink,n+1) = -1;
      else
        obj.status = 2;
        Source.fillCirM(obj);
      end
      circuitM(m+1,obj.source) = 1;
      circuitM(m+1,obj.sink) = -1;
      knownM(m+1,1) = 0;
    end
  end
end
