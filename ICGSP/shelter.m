function result = shelter( C, x)
    h = length(C(1,:));
    w = length(C(:, 1));
    temp1 = zeros(fix(w/x), h);
    temp2 = ones(w -fix(w/x) , h);
    result = [temp1; temp2];
    result = result.*C;

end

