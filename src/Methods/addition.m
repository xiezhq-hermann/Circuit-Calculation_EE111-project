function addition
  % This function is exactly a script
  % This script insert more additional information to circuit matrix
  % Such as relation between Components or exact value.
  global additionData circuitM knownM;
  sizeData = size(additionData);
  for i = 1:sizeData(1)
    [m,n] = size(circuitM);
    switch additionData{i,1}
      case 'Voltage'
        base1 = findObj(additionData{i,2});
        circuitM(m+1,base1.source) = 1;
        circuitM(m+1,base1.sink) = -1;
        switch additionData{i,4}
          case 'Voltage'
            base2 = findObj(additionData{i,5});
            rate = additionData{i,3};
            circuitM(m+1,base2.source) = circuitM(m+1,base2.source) -rate;
            circuitM(m+1,base2.sink) = circuitM(m+1,base2.sink) + rate;
            knownM(m+1,1) = 0;
          case 'Current'
            base2 = findObj(additionData{i,5});
            rate = additionData{i,3};
            circuitM(m+1,base2.getCurrentIn()) = circuitM(m+1,base2.getCurrentIn()) -rate;
            knownM(m+1,1) = 0;
          otherwise
            knownM(m+1,1) = additionData{i,3};
        end
      case 'Current'
        base1 = findObj(additionData{i,2});
        circuitM(m+1,base1.getCurrentIn()) = 1;
        switch additionData{i,4}
          case 'Voltage'
            base2 = findObj(additionData{i,5});
            rate = additionData{i,3};
            circuitM(m+1,base2.source) = circuitM(m+1,base2.source) -rate;
            circuitM(m+1,base2.sink) = circuitM(m+1,base2.sink) + rate;
            knownM(m+1,1) = 0;
          case 'Current'
            base2 = findObj(additionData{i,5});
            rate = additionData{i,3};
            circuitM(m+1,base2.getCurrentIn()) = circuitM(m+1,base2.getCurrentIn()) -rate;
            knownM(m+1,1) = 0;
          otherwise
            knownM(m+1,1) = additionData{i,3};
        end
      otherwise
        break;
     end
   end
end
