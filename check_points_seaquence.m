function [pts, mode, sz, pdim, planarflag] = check_points_seaquence(points, dim, pmin) 
%	CHECK_POINTS_SEAQUENCE	入力点列のチェック
%	
%	mode:
%		0 : 3×N
%		1 : N×3
%		2 : 1×N×3
%		3 : N×1×3

% --
%	Title : CHECK_POINTS_SEAQUENCE()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/23
% //-- 

%%% 入力チェック 
error(nargchk(2, 3, nargin));

if ~isnumeric(points) 
	error('入力点列は実数値である必要があります。');
end;

% 入力点列の次元チェック 
sz = size(points);
pdim = ndims(points);
planarflag = 0;

% 2次元の場合の処理
if any(sz==2) 
	if dim==0 
		dim = find(sz==2);
		dim = dim(1);
	end;

	if sz(dim)==2 
		sz0 = sz;
		sz(dim) = 3;
		ptmp = zeros(sz);
		ptmp(1:sz0(1), 1:sz0(2)) = points;
		points = ptmp;
		planarflag = 1;
	end;
end;

if dim==0 
	dim = find(sz==3);
	dim = dim(1);
end;

if nargin<3 pmin=3; end;

if pdim>3 | numel(points)<3*pmin | ~any(sz==3) 
	error(strcat(['入力点列は，3次元でかつ', pmin, '点以上の点を含む必要があります。']));
end;

if ~isequal(dim,floor(dim)) | numel(dim)~=1 | pdim<dim | sz(dim)~=3 
	error('次元の引数は、インデックス付け範囲の中で、正の整数のスカラでなければなりません。');
end;

pts = zeros(3, floor(numel(points)/3));
mode = 0;

if dim==1 
	pts = points;
elseif dim==2 
	pts = points';
	mode = 1;
elseif dim==3 
	if sz(1)==1 
		mode = 2;
		pts = squeeze(points)';
	else 
		mode = 3;
		pts = squeeze(points)';
	end;
end;
%%%
