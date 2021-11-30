function RR = curvatureR_numeric(points, dim) 
%	CURVATURER_NUMERIC	点列の数値的に求めた曲率半径
%	
%	R = CURVATURER_NUMERIC(P)は，点列Pから各点における曲率半径Rを求めます。
%	R = CURVATURER_NUMERIC(P, DIM)は，点ベクトルの形式をDIMで指定して，点列Pから各点における曲率半径Rを求めます。
%
%	例:
%		この例は1点が列ベクトルで表された点列の各点における曲率半径Rを生成します。
%		R = CURVATURER_NUMERIC(P)
% 
%		この例は1点が行ベクトルで表された点列の各点における曲率半径Rを生成します。
%		R = CURVATURER_NUMERIC(P,2)

% --
%	Title : CURVATURER_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/24 
% //-- 
error(nargchk(1, 2, nargin));
if nargin==1 
	dim=0;
end;

kk = curvature_numeric(points, dim)
RR = abs(1./kk);
