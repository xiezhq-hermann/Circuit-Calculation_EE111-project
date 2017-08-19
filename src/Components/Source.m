classdef Source < Component
  properties
    voltage
  end
  methods(Static)
    function obj = Source(name, source, sink, voltage, current)
      obj@Component(name, source, sink);
      obj.status = 0;
      if ~isempty(voltage)
        obj.voltage = voltage;
        obj.status = obj.status + 1;
      end
      if ~isempty(current)
        obj.current = current;
        obj.status  = obj.status + 2;
      end
    end
    function fillCirM(obj,index)
      global circuitM solutionM knownM allComponent;
      [m,n] = size(circuitM);
      switch obj.status
        case 0
          solutionM(n+1,1) = 0;
          allComponent{index}.solutionIndex = n+1;
          circuitM(obj.source,n+1) = 1;
          circuitM(obj.sink,n+1) = -1;
        case 1
          solutionM(n+1,1) = 0;
          allComponent{index}.solutionIndex = n+1;
          circuitM(obj.source,n+1) = 1;
          circuitM(obj.sink,n+1) = -1;
          circuitM(m+1,obj.source) = 1;
          circuitM(m+1,obj.sink) = -1;
          knownM(m+1,1) = obj.voltage;
        case 2
          knownM(obj.sink) = knownM(obj.sink) + obj.current;
          knownM(obj.source) = knownM(obj.source) - obj.current;
        case 3
          knownM(obj.sink) = knownM(obj.sink) + obj.current;
          knownM(obj.source) = knownM(obj.source) - obj.current;
          circuitM(m+1,obj.source) = 1;
          circuitM(m+1,obj.sink) = -1;
          knownM(m+1,1) = obj.voltage;
      end
    end
  end
end
