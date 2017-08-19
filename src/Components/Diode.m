classdef Diode < Component
  properties
    threshold
    offResistance = 1e8;
    onResistance = 1e-6;
  end
  methods
    function obj = Diode(name,source,sink,threshold)
      obj@Component(name,source,sink);
      obj.threshold = threshold;
      obj.status = 0;
    end
    function adding(obj,index)
      global circuitM knownM solutionM diode;
      [m,n] = size(circuitM);
      if obj.status == 0
        % This part made the diode into conduct network
        circuitM(obj.source,obj.source) = circuitM(obj.source,obj.source) + 1/obj.offResistance;
        circuitM(obj.sink,obj.sink) = circuitM(obj.sink,obj.sink) + 1/obj.offResistance;
        circuitM(obj.source,obj.sink) = circuitM(obj.source,obj.sink) - 1/obj.offResistance;
        circuitM(obj.sink,obj.source) = circuitM(obj.sink,obj.source) - 1/obj.offResistance;

        % This part is for solving current
        solutionM(n+1,1) = 0;
        diode{index}.solutionIndex = n+1;
        circuitM(m+1,obj.source) = 1/obj.offResistance;
        circuitM(m+1,obj.sink) = -1/obj.offResistance;
        circuitM(m+1,n+1) = -1;
        knownM(m+1) = 0;
      else
        % make it like a voltage source
        %{
        solutionM(n+1,1) = 0;
        diode{index}.solutionIndex = n+1;
        circuitM(obj.source,n+1) = 1;
        circuitM(obj.sink,n+1) = -1;
        circuitM(m+1,obj.source) = 1;
        circuitM(m+1,obj.sink) = -1;
        knownM(m+1) = obj.threshold;
        %}
        circuitM(obj.source,obj.source) = circuitM(obj.source,obj.source) + 1/obj.onResistance;
        circuitM(obj.sink,obj.sink) = circuitM(obj.sink,obj.sink) + 1/obj.onResistance;
        circuitM(obj.source,obj.sink) = circuitM(obj.source,obj.sink) - 1/obj.onResistance;
        circuitM(obj.sink,obj.source) = circuitM(obj.sink,obj.source) - 1/obj.onResistance;
        solutionM(n+1,1) = 0;
        diode{index}.solutionIndex = n+1;
        circuitM(obj.source, n+1) = 1;
        circuitM(obj.sink, n+1) = -1;
        circuitM(m+1, obj.source) = 1;
        circuitM(m+1, obj.sink) = -1;
        circuitM(m+1, n+1) = -obj.onResistance;
        knownM(obj.source) = knownM(obj.source) + obj.threshold/obj.onResistance;
        knownM(obj.sink) = knownM(obj.sink) - obj.threshold/obj.onResistance;
        knownM(m+1) = obj.threshold;
      end
    end
    function check = checking(obj)
        global solutionM
        voltage = solutionM(obj.source) - solutionM(obj.sink);
        if voltage >= obj.threshold
            if obj.status == 1;
                check = true;
            else
                check = false;
            end
        else
            if obj.status == 0
                check = true;
            else
                check = false;
            end
        end
    end
  end
end
