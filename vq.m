function cb = vq(final)
c = 20; %centroid
e = 0.01;
 
cb = mean(final,2); % Defining the codebook by averaging all columns i a row
d = inf;

for j = 1:log2(c)
    cb = [cb * (1 + e), cb * (1 - e)];

    while (true)
        d = dist(final,cb);
        [a, i] = min (d,[],2);
        temp = 0;
        for k = 1:2^j
            cb(:,k) = mean(final(:,find(i==k)),2);
            b = dist(final(:, find(i==k)),cb(:,k));
            l = length(b);
            for l = 1:l
                temp = temp + b(l);
            end
        end
        if (((d-temp)/temp) < e)
            break;
        else 
            d = temp;
        end
    end
end


end

