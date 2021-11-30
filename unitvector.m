function UV = unitvector(V,dim)
% UNITVECTOR ベクトルの単位ベクトル化。
% 
%	UNITVECTOR(V)は列ベクトルとしてひとつのベクトルが表されたベクトル配列Vの各列の単位ベクトルを返します。
%			また，UNITVECTOR(V)は、UNITVECTOR(V, 1)と同じです。
%	UNITVECTOR(V, DIM)は単位化する次元を指定したベクトル配列Vの各列の単位ベクトルを返します。
%
%	例 :
%	列ベクトルAの単位ベクトル．
%		A = [2;2;0];
%		unitvector(A)
%
%	行ベクトルAの単位ベクトル．
%		A = [2,2,0];
%		unitvector(A,2)
%
%	ベクトル配列Bの各行の単位ベクトル
%		B = [[0;4;0],[1;1;1],[2;0;3],[3;2;1],[4;1;0],[5;1;1]];
%		unitvector(B)
%

% --
%	Title : UNITVECTOR() 
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Version: 1.0 $ : 2006/12/01 
%	Version: 2.0 $ : 2007/12/03 
%			(行で表されたベクトルにも対応)
%	Version: 2.1 $ : 2008/01/23 
%			(正方根の中が負になったときの処理追加)
% //--

error(nargchk(1, 2, nargin));

if nargin==1 dim=1; end;

if ~isreal(V) 
	error('ベクトルは実数配列である必要があります。'); 
end;

if ~isequal(dim,floor(dim)) || numel(dim)~=1 || ndims(V)<dim 
	error('次元の引数は、インデックス付け範囲の中で、正の整数のスカラでなければなりません。');
end;

sz = size(V);
sz2 = ones(1,ndims(V));
sz2(dim) = sz(dim);

vnorm = real(sqrt(sum(V.^2,dim)));
vnorm = repmat(vnorm,sz2);
vnorm = reshape(vnorm,sz);

if any(vnorm==0) 
	warning('ゼロ割りです。NaNもしくはInfになっているベクトルがあります。');
end;

UV = V./vnorm;
