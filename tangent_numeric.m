function TVEC = tangent_numeric(points, dim)
%	TANGENT_NUMERIC	点列の数値的に求めた接線
%	
%	TVEC = TANGENT_NUMERIC(P)は，点列Pから各点における接線TVECを求めます。
%	TVEC = TANGENT_NUMERIC(P, DIM)は，点ベクトルの形式をDIMで指定して，点列Pから各点における接線TVECを求めます。
%
%	例:
%		この例は1点が列ベクトルで表された点列の各点における接線TVECを生成します。
%		TVEC = TANGENT_NUMERIC(P)
% 
%		この例は1点が行ベクトルで表された点列の各点における接線TVECを生成します。
%		TVEC = TANGENT_NUMERIC(P,2)

% --
%	Title : TANGENT_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/08
% //-- 

error(nargchk(1, 2, nargin));

if nargin==1 
	dim=0;
end;
[pts, mode, sz, pdim, planarflag] = check_points_seaquence(points, dim, 2);

%% 従法線の計算
tv = zeros(size(pts));
tv(:,1) = pts(:,2) - pts(:,1);
tv(:,end) = pts(:,end) - pts(:,end-1);
tv(:,2:(end-1)) = pts(:,3:end) - pts(:,1:(end-2));
tv = unitvector(tv,1);

%% 出力用に整形
TVEC = reshape_points_seaquence(tv, mode, sz, planarflag);
