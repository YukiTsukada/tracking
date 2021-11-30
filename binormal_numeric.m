function BVEC = binormal_numeric(points, dim) 
%	BINORMAL_NUMERIC	�_��̐��l�I�ɋ��߂��]�@��
%	
%	BVEC = BINORMAL_NUMERIC(P)�́C�_��P����e�_�ɂ�����]�@��BVEC�����߂܂��B
%	BVEC = BINORMAL_NUMERIC(P, DIM)�́C�_�x�N�g���̌`����DIM�Ŏw�肵�āC�_��P����e�_�ɂ�����]�@��BVEC�����߂܂��B
%
%	��:
%		���̗��1�_����x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����]�@��BVEC�𐶐����܂��B
%		BVEC = BINORMAL_NUMERIC(P)
% 
%		���̗��1�_���s�x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����]�@��BVEC�𐶐����܂��B
%		BVEC = BINORMAL_NUMERIC(P,2)

% --
%	Title : BINORMAL_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/23
% //-- 

%%% ���̓`�F�b�N 
error(nargchk(1, 2, nargin));
if nargin==1 
	dim=0;
end;
[pts, mode, sz, pdim] = check_points_seaquence(points, dim);

%% �]�@���̌v�Z
v1 = pts(:,1:(end-2)) - pts(:,2:(end-1));
v2 = pts(:,3:end) - pts(:,2:(end-1));

bv = zeros(size(pts));
bv(:,2:(end-1)) = cross(v2, v1);
bv(:,1) = bv(:,2);
bv(:,end) = bv(:,end-1);
bv = unitvector(bv,1);

%% �o�͗p�ɐ��`
BVEC = reshape_points_seaquence(bv, mode, sz);
