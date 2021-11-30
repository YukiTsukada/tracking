%
%
function template(IM,Temp)
[Y X] = size(IM);
[TY TX] = size(Temp);

for i = 1:Y-TY
  for j = 1:X-TX
    A = IM(i:i+TY-1,j:j+TX-1);
    AA = double(reshape(A,1,TY*TX));
    TT = double(reshape(Temp,1,TY*TX));
    corrcoef(AA,TT);
  end
end