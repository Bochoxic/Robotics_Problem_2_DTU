function cond_num = getCondNumPath(thetas)

    cond_num = [];
    for i=1:size(thetas,1)
        [J4, ~] = JacobianMatrix(thetas(i,1),thetas(i,2), thetas(i,3), thetas(i,4));
        cond_num = [cond_num; cond(J4)];
    end

end