

function sim_track(n)

for i = 1:n
  FILE = sprintf('1x2/%d.tif',i);
  IM = imread(FILE);
  head(IM);
end