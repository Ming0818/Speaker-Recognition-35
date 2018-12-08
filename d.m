function data = d()

[s1,fs1] = audioread('s1.wav');
[s2,fs2] = audioread('s2.wav');
a1 = mf(s1,fs1);
a2 = mf(s2,fs2);

a3 = vq(a1);
a4 = vq(a2);

data{1} = a3;
data{2} = a4;

end

