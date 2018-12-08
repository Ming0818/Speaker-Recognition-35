
dataset = d();
[s1,fs1] = audioread('s1.wav');
[s2,fs2] = audioread('s2.wav');

a1 = mf(s1,fs1);
a2 = mf(s2,fs2);
c = {a1,a2};

d1 = inf;
d2 = 0;

a = length(dataset);

for i = 1:a
    p1 = dist(c{1},dataset{i});
    p2 = sum(min(p1,[],2))/size(p1,1);
    
    if p2 < d1;
       d1 = p2;
       d2 = i;
       flag = d2;
    end
    
end
msg = sprintf('Speaker %d matches with speaker %d', 1, d2);
disp(msg);



