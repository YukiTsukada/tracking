%
% simulate auto focus

function sim_autofocus(n)
     
for i = 1:n
  FILE = sprintf('2x2-F50/A%d',i);
  IM = imread(FILE);
  IMM = IM(:,:,1);
  f = fspecial('gaussian',2,3);
  IMF = imfilter(IMM,f,'replicate');
  [RAW COL] = size(IMM);
  IMM2 = reshape(IMF,1,RAW*COL);
  V(i) = var(double(IMM2));
end

plot(V);
