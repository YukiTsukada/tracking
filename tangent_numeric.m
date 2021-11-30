function TVEC = tangent_numeric(points, dim)
%	TANGENT_NUMERIC	�_��̐��l�I�ɋ��߂��ڐ�
%	
%	TVEC = TANGENT_NUMERIC(P)�́C�_��P����e�_�ɂ�����ڐ�TVEC�����߂܂��B
%	TVEC = TANGENT_NUMERIC(P, DIM)�́C�_�x�N�g���̌`����DIM�Ŏw�肵�āC�_��P����e�_�ɂ�����ڐ�TVEC�����߂܂��B
%
%	��:
%		���̗��1�_����x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����ڐ�TVEC�𐶐����܂��B
%		TVEC = TANGENT_NUMERIC(P)
% 
%		���̗��1�_���s�x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����ڐ�TVEC�𐶐����܂��B
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

%% �]�@���̌v�Z
tv = zeros(size(pts));
tv(:,1) = pts(:,2) - pts(:,1);
tv(:,end) = pts(:,end) - pts(:,end-1);
tv(:,2:(end-1)) = pts(:,3:end) - pts(:,1:(end-2));
tv = unitvector(tv,1);

%% �o�͗p�ɐ��`
TVEC = reshape_points_seaquence(tv, mode, sz, planarflag);
