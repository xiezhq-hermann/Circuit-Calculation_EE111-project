function preRead(nodeN)
  % This function handle the input.
  % nodeN is the maximum number of node.
  % This function make all Components to specific cell array.
  global angularF opAmp diode basisData sourceData opAmpData allComponent circuitM solutionM knownM;
  angularF = 300;
  circuitM = zeros(nodeN,nodeN);
  solutionM = zeros(nodeN,1);
  knownM = zeros(nodeN,1);

  sizeData = size(basisData);
  diodeN = 0;
  for amount = 1:sizeData(1)
    switch basisData{amount,1}
    case ''
      amount = amount - 1 - diodeN;
      break;
    case 'Blank'
      amount = amount - 1 - diodeN;
      break;
    case 'Diode'
      diodeN = diodeN + 1;
    otherwise
      continue;
    end
  end

  sizeData = size(sourceData);
  for amountS = 1:sizeData(1)
    switch sourceData{amountS,1}
    case ''
      amountS = amountS - 1;
      break;
    otherwise
      continue;
    end
  end

  sizeData = size(opAmpData);
  for amountAmp = 1:sizeData(1)
    switch opAmpData{amountAmp,1}
    case ''
      amountAmp = amountAmp - 1;
      break;
    otherwise
      continue;
    end
  end

  if diodeN > 0
    diode{diodeN} = {};
  end
  if amountAmp > 0
    opAmp{amountAmp} = {};
  end
  if amount + amountS > 0
    allComponent{amount+amountS} = {};
  end

  j = 0;
  for i = 1:(amount+diodeN)
    switch basisData{i,1}
      case ''
        disp('Something wrong');
        break;
      case 'Resistor'
        allComponent{i-j} = Resistor(basisData{i,2:5});
      case 'Wire'
        allComponent{i-j} = Wire(basisData{i,2:5});
      case 'Diode'
        j = j + 1;
        diode{j} = Diode(basisData{i,2:5});
      case 'Capacitor'
        allComponent{i-j} = ComplexE(basisData{i,2:5},'C');
      case 'Inductor'
        allComponent{i-j} = ComplexE(basisData{i,2:5},'L');
    end
  end

  for i1 = 1:amountS
    if isempty(sourceData{i1,1})
      disp('Something wrong');
      break;
    else
      allComponent{amount+i1} = Source(sourceData{i1,1:5});
    end
  end

  for i2 = 1:amountAmp
    if isempty(opAmpData{i2,1})
      disp('Something wrong');
      break;
    else
      opAmp{i2} = OpAmp(opAmpData{i2,1:4});
    end
  end
  calculate;
end
