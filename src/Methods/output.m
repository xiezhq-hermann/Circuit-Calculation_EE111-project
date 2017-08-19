function output
  global allComponent diode opAmp;

  amount = length(allComponent);
  if amount > 0
    nameArray{amount} = {};
    Voltage = zeros(amount,1);
    Current = zeros(amount,1);
    for i = 1:amount
      nameArray{i} = allComponent{i}.name;
      Voltage(i,1) = allComponent{i}.getVoltage();
      Current(i,1) = allComponent{i}.getCurrentVal();
    end
    T1 = table(Voltage,Current,'RowNames',nameArray');
    figure;
    uitable('Data',T1{:,:},'ColumnName',T1.Properties.VariableNames,...
      'RowName',T1.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
  end

  amountDi = length(diode);
  if amountDi > 0
    nameArrayD{amountDi} = {};
    State = zeros(amountDi,1);
    CurrentD = zeros(amountDi,1);
  for j = 1:amountDi
    nameArrayD{j} = diode{j}.name;
    State(j,1) = diode{j}.status;
    CurrentD(j,1) = diode{j}.getCurrentVal();
  end
  T2 = table(State,CurrentD,'RowNames',nameArrayD');
  figure;
  uitable('Data',T2{:,:},'ColumnName',T2.Properties.VariableNames,...
    'RowName',T2.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
  end

  amountAmp = length(opAmp);
  if amountAmp > 0
    nameArrayAmp{amountAmp} = {};
    outPointV = zeros(amountAmp,1);
    outPointI = zeros(amountAmp,1);
  for k = 1:amountAmp
    nameArrayAmp{k} = opAmp{k}.name;
    outPointV(k,1) = opAmp{k}.getVoltage();
    outPointI(k,1) = opAmp{k}.getCurrentVal();
  end
  T3 = table(outPointV,outPointI,'RowNames',nameArrayAmp');
  figure;
  uitable('Data',T3{:,:},'ColumnName',T3.Properties.VariableNames,...
    'RowName',T3.Properties.RowNames,'Units', 'Normalized', 'Position',[0, 0, 1, 1]);
  end

end
