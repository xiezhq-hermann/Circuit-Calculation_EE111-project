classdef Resistor < Component
  properties
    conductance
  end
  methods(Static)
    function obj = Resistor(name,source,sink,resistance)
      global circuitM knownM solutionM;
      obj@Component(name, source, sink);
      obj.status = 0;
      if ~isempty(resistance)
        obj.conductance = 1/resistance;
        circuitM(obj.source,obj.source) = circuitM(obj.source,obj.source) + obj.conductance;
        circuitM(obj.sink,obj.sink) = circuitM(obj.sink,obj.sink) + obj.conductance;
        circuitM(obj.source,obj.sink) = circuitM(obj.source,obj.sink) - obj.conductance;
        circuitM(obj.sink,obj.source) = circuitM(obj.sink,obj.source) - obj.conductance;
        obj.status = 4;
        [m,n] = size(circuitM);
        solutionM(n+1,1) = 0;
        obj.solutionIndex = n+1;
        circuitM(m+1,obj.source) = obj.conductance;
        circuitM(m+1,obj.sink) = -obj.conductance;
        circuitM(m+1,n+1) = -1;
        knownM(m+1) = 0;
      end
    end

    function fillCirM(obj,index)
      global solutionM circuitM allComponent;
      if obj.status ~= 0
        return;
      else
        [m,n] = size(circuitM);
        solutionM(n+1,1) = 0;
        allComponent{index}.solutionIndex = n+1;
        circuitM(obj.source,n+1) = 1;
        circuitM(obj.sink,n+1) = -1;
      end
    end
  end
end
