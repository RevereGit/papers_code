function result = rubustnoise( C, p )
    result = C.*(1 + p*rand (length(C(:,1)), length(C(1, :))));
end

