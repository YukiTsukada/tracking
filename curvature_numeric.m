function KAPPA = curvature_numeric(points, dim) 
%	CURVATURE_NUMERIC	�_��̐��l�I�ɋ��߂��ȗ�
%	
%	C = CURVATURE_NUMERIC(P)�́C�_��P����e�_�ɂ�����ȗ�C�����߂܂��B
%	C = CURVATURE_NUMERIC(P, DIM)�́C�_�x�N�g���̌`����DIM�Ŏw�肵�āC�_��P����e�_�ɂ�����ȗ�C�����߂܂��B
%
%	��:
%		���̗��1�_����x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����ȗ�C�𐶐����܂��B
%		C = CURVATURE_NUMERIC(P)
% 
%		���̗��1�_���s�x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����ȗ�C�𐶐����܂��B
%		C = CURVATURE_NUMERIC(P,2)

% --
%	Title : CURVATURE_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/24 
% //-- 

%%% ���̓`�F�b�N 
error(nargchk(1, 2, nargin));
if nargin==1 
	dim=0;
end;
[pts, mode, sz, pdim, planarmode] = check_points_seaquence(points, dim);

%% �ȗ��̌v�Z
v1 = pts(:,1:(end-2)) - pts(:,2:(end-1));
v2 = pts(:,3:end) - pts(:,2:(end-1));
v3 = pts(:,3:end) - pts(:,1:(end-2));

ff = zeros(size(pts));
ff(:,2:(end-1)) = cross(v2, v1);

v1s = real(sqrt(sum(v1.*v1)));
v2s = real(sqrt(sum(v2.*v2)));
v3s = real(sqrt(sum(v3.*v3)));
gg = v1s.*v2s.*v3s;

kk =zeros(1,size(pts,2));
if planarmode==1 
	kk(2:(end-1)) = 2*ff(3,2:(end-1))./gg;
else
	kk(2:(end-1)) = 2*real(sqrt(sum(ff(:,2:(end-1)).^2)))./gg;
end;
kk(1) = kk(2);
kk(end) = kk(end-1);

% �T�C�Y�̏C��
switch mode 
	case 0 
		sz(1) = 1;
	case 1 
		sz(2) = 2;
	otherwise
		sz(3) = [];
end;

%% �o�͗p�ɐ��`
KAPPA = reshape_points_seaquence(kk, mode, sz);
