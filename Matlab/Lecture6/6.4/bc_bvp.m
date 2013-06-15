function bc=bc_bvp(yl,yr,beta)
bc=[yl(1); yl(2)-0.1; yr(1)];


% bc_bvp(yl,yr,beta) 中，yl,yr,beta 是参数
% bc 是函数返回的结果。
% 这里我们返回的是[yl(1); yl(2)-0.1; yr(1)]