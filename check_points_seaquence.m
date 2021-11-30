function [pts, mode, sz, pdim, planarflag] = check_points_seaquence(points, dim, pmin) 
%	CHECK_POINTS_SEAQUENCE	���͓_��̃`�F�b�N
%	
%	mode:
%		0 : 3�~N
%		1 : N�~3
%		2 : 1�~N�~3
%		3 : N�~1�~3

% --
%	Title : CHECK_POINTS_SEAQUENCE()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/23
% //-- 

%%% ���̓`�F�b�N 
error(nargchk(2, 3, nargin));

if ~isnumeric(points) 
	error('���͓_��͎����l�ł���K�v������܂��B');
end;

% ���͓_��̎����`�F�b�N 
sz = size(points);
pdim = ndims(points);
planarflag = 0;

% 2�����̏ꍇ�̏���
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
	error(strcat(['���͓_��́C3�����ł���', pmin, '�_�ȏ�̓_���܂ޕK�v������܂��B']));
end;

if ~isequal(dim,floor(dim)) | numel(dim)~=1 | pdim<dim | sz(dim)~=3 
	error('�����̈����́A�C���f�b�N�X�t���͈͂̒��ŁA���̐����̃X�J���łȂ���΂Ȃ�܂���B');
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