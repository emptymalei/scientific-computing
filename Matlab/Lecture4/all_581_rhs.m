function rhs=all_581_rhs(x,ic,dummy,beta)
y1=ic(1)
y2=ic(2)
rhs=[y2
    (beta-100)*y1];