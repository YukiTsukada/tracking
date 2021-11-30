function NVEC = normal_numeric(points, dim) 
%	NORMAL_NUMERIC	点列の数値的に求めた主法線
%	
%	NVEC = NORMAL_NUMERIC(P)は，点列Pから各点における主法線NVECを求めます。
%	NVEC = NORMAL_NUMERIC(P, DIM)は，点ベクトルの形式をDIMで指定して，点列Pから各点における主法線NVECを求めます。
%
%	例:
%		この例は1点が列ベクトルで表された点列の各点における主法線NVECを生成します。
%		NVEC = NORMAL_NUMERIC(P)
% 
%		この例は1点が行ベクトルで表された点列の各点における主法線NVECを生成します。
%		NVEC = NORMAL_NUMERIC(P,2)

% --
%	Title : NORMAL_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/23
% //-- 

%%% 入力チェック 
error(nargchk(1, 2, nargin));
if nargin==1 
	dim=0;
end;
[pts, mode, sz, pdim, planarflag] = check_points_seaquence(points, dim);
tv = tangent_numeric(pts, 1);
bv = binormal_numeric(pts, 1);
nv = unitvector(cross(bv, tv));

%% 出力用に整形
NVEC = reshape_points_seaquence(nv, mode, sz, planarflag);
