function copy = findObj(objName)
  % This function is for traverse the whole array.
  % copy means a copy of the struct object.
  % Be careful about copy not pointer
  global allComponent;
  for i = 1:length(allComponent)
    if strcmp(allComponent{i}.name,objName)
      copy = allComponent{i};
      return;
    else
      continue;
    end
  end
  disp('The name is undifined');
end
