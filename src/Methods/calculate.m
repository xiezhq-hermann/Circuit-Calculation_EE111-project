global  circuitM solutionM knownM opAmp diode allComponent;

for i = 1:length(allComponent)
  allComponent{i}.fillCirM(allComponent{i},i);
end

for op = 1:length(opAmp)
    opAmp{op}.adding(op);
end

addition;

diodeN = length(diode);
backupCir = circuitM;
backupKnow = knownM;

for states = 0:(2^diodeN-1)
    circuitM = backupCir;
    knownM = backupKnow;
    diodeS = dec2bin(states,diodeN);
    tag = 1;
    for every = diodeS
        diode{tag}.status = str2double(every);
        diode{tag}.adding(tag);
        tag = tag + 1;
    end
    solutionM(2:end,1) = circuitM(2:end,2:end)\knownM(2:end,1);
    for dio = 1:diodeN
        checkD = diode{dio};
        if checkD.checking()
          if dio == diodeN
            output;
            return;
          end
        else
            break;
        end
    end
    continue;
end
output;
