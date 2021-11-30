%
%
function [Y X] = ent(IM,n)

[Raw Col] = size(IM);

for i = 1:n:Raw - n
  for j = 1:n:Col - n
    E = IM(i:i+n,j:j+n);
    Ent(i,j) = entropy(E);
  end
end
[RawE ColE] = size(Ent);
ReEnt = reshape(Ent,RawE*ColE,1);
imagesc(Ent);
MaxE  = max(ReEnt);
[EntY EntX] = find(Ent == MaxE);
hold on;
%plot(EntX,EntY,'ow');
X = EntX(1); Y = EntY(1);
