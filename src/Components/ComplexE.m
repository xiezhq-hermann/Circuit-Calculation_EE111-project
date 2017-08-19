classdef ComplexE < Component
  properties
    admittance
  end
  methods(Static)
    function obj = ComplexE(name,source,sink,complex,indicate)
      obj@Component(name, source, sink);
      global angularF circuitM knownM solutionM;
      switch indicate
        case 'C'
          obj.admittance = complex*1i*angularF;
        case 'L'
          obj.admittance = 1/(1i*complex*angularF);
      end
      circuitM(obj.source,obj.source) = circuitM(obj.source,obj.source) + obj.admittance;
      circuitM(obj.sink,obj.sink) = circuitM(obj.sink,obj.sink) + obj.admittance;
      circuitM(obj.source,obj.sink) = circuitM(obj.source,obj.sink) - obj.admittance;
      circuitM(obj.sink,obj.source) = circuitM(obj.sink,obj.source) - obj.admittance;
      [m,n] = size(circuitM);
      solutionM(n+1,1) = 0;
      obj.solutionIndex = n+1;
      circuitM(m+1,obj.source) = obj.admittance;
      circuitM(m+1,obj.sink) = -obj.admittance;
      circuitM(m+1,n+1) = -1;
      knownM(m+1) = 0;
    end
  end
end
%{
if rank(incidenceM) == 0
    edge = 1;
else
    edge = size(incidenceM,1) + 1;
end
incidenceM(edge,obj.source) = -1;
incidenceM(edge,obj.sink) = 1;
if size(conductM,1) >= edge
  conductM(edge,edge) = conductM(edge,edge) + obj.admittance;
else
  conductM(edge,edge) = obj.admittance;
end
%}
