classdef Component
  properties
    name
    source
    sink
    current
    solutionIndex
    status
  end
  methods
    function obj = Component(name, source, sink)
      obj.name = name;
      obj.source = source;
      obj.sink = sink;
    end
    function fillCirM(obj,index)
      disp('Notice');
    end
    function currentIn = getCurrentIn(obj)
      if ~isempty(obj.solutionIndex)
        currentIn = obj.solutionIndex;
      else
        currentIn = 0;
        disp('Here is a known value');
      end
    end
    function currentVal = getCurrentVal(obj)
      global solutionM;
      if ~isempty(obj.current)
        currentVal = obj.current;
      else
        currentVal = solutionM(obj.solutionIndex);
      end
    end
    function voltageVal = getVoltage(obj)
      global solutionM;
      voltageVal = solutionM(obj.source,1) - solutionM(obj.sink,1);
      return;
    end
  end
end
