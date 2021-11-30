function BVEC = binormal_numeric(points, dim) 
%	BINORMAL_NUMERIC	点列の数値的に求めた従法線
%	
%	BVEC = BINORMAL_NUMERIC(P)は，点列Pから各点における従法線BVECを求めます。
%	BVEC = BINORMAL_NUMERIC(P, DIM)は，点ベクトルの形式をDIMで指定して，点列Pから各点における従法線BVECを求めます。
%
%	例:
%		この例は1点が列ベクトルで表された点列の各点における従法線BVECを生成します。
%		BVEC = BINORMAL_NUMERIC(P)
% 
%		この例は1点が行ベクトルで表された点列の各点における従法線BVECを生成します。
%		BVEC = BINORMAL_NUMERIC(P,2)

% --
%	Title : BINORMAL_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/23
% //-- 

%%% 入力チェック 
error(nargchk(1, 2, nargin));
if nargin==1 
	dim=0;
end;
[pts, mode, sz, pdim] = check_points_seaquence(points, dim);

%% 従法線の計算
v1 = pts(:,1:(end-2)) - pts(:,2:(end-1));
v2 = pts(:,3:end) - pts(:,2:(end-1));

bv = zeros(size(pts));
bv(:,2:(end-1)) = cross(v2, v1);
bv(:,1) = bv(:,2);
bv(:,end) = bv(:,end-1);
bv = unitvector(bv,1);

%% 出力用に整形
BVEC = reshape_points_seaquence(bv, mode, sz);
