function RR = curvatureR_numeric(points, dim) 
%	CURVATURER_NUMERIC	�_��̐��l�I�ɋ��߂��ȗ����a
%	
%	R = CURVATURER_NUMERIC(P)�́C�_��P����e�_�ɂ�����ȗ����aR�����߂܂��B
%	R = CURVATURER_NUMERIC(P, DIM)�́C�_�x�N�g���̌`����DIM�Ŏw�肵�āC�_��P����e�_�ɂ�����ȗ����aR�����߂܂��B
%
%	��:
%		���̗��1�_����x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����ȗ����aR�𐶐����܂��B
%		R = CURVATURER_NUMERIC(P)
% 
%		���̗��1�_���s�x�N�g���ŕ\���ꂽ�_��̊e�_�ɂ�����ȗ����aR�𐶐����܂��B
%		R = CURVATURER_NUMERIC(P,2)

% --
%	Title : CURVATURER_NUMERIC()
%	Author : Sach1o : http://sach1o.blog80.fc2.com/
%	Created : 2008/01/24 
% //-- 
error(nargchk(1, 2, nargin));
if nargin==1 
	dim=0;
end;

kk = curvature_numeric(points, dim)
RR = abs(1./kk);
