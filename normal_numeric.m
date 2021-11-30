function NVEC = normal_numeric(points, dim) 
%	NORMAL_NUMERIC	�_��̐��l�I�ɋ��߂���@��
%	
%	NVEC = NORMAL_NUMERIC(P)�́C�_��P����e�_�ɂ������@��NVEC�����߂܂��B
%	NVEC = NORMAL_NUMERIC(P, DIM)�́C�_�x�N�g���̌`����DIM�Ŏw�肵�āC�_��P����e�_�ɂ������@��NVEC�����߂܂��B
%
%	��:
%		���̗��1�_����x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ������@��NVEC�𐶐����܂��B
%		NVEC = NORMAL_NUMERIC(P)
% 
%		���̗��1�_���s�x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ������@��NVEC�𐶐����܂��B
%		NVEC = NORMAL_NUMERIC(P,2)

% --
%	Title : NORMAL_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/23
% //-- 

%%% ���̓`�F�b�N 
error(nargchk(1, 2, nargin));
if nargin==1 
	dim=0;
end;
[pts, mode, sz, pdim, planarflag] = check_points_seaquence(points, dim);
tv = tangent_numeric(pts, 1);
bv = binormal_numeric(pts, 1);
nv = unitvector(cross(bv, tv));

%% �o�͗p�ɐ��`
NVEC = reshape_points_seaquence(nv, mode, sz, planarflag);
