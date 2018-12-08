function a = mf(x,fs)

%figure,plot (y);
%title('Recording');


%
%Frame Blocking
M = 100; % M samples gap
N = 256; % N samples

len = length(x);

  NN = floor(N/2+1);
n_frames = floor((len-N)/M) + 1 ;
frames = zeros(n_frames+1,N);

for i = 0:n_frames-1
    frames(i+1,1:N) = x(i*M+1 : i*M+N); 
end    

val = zeros(1,N); 
ll = length(x)- n_frames*M;
val(1:ll) = x(n_frames*M+1:(n_frames*M +1 + ll-1));  
frames(n_frames+1, 1:N) = val;
    
%end


%plot(frames);

% Windowing
n_frames = n_frames + 1;
ham = hamming(N); %hamming window
ham = ham';
y_n = zeros(n_frames,N);

for i = 1:n_frames
    y_n(i, 1:N) = frames(i, 1:N) .* ham;
end    

% FFT
f_trans = (fft(y_n));

f_trans = f_trans' ;
% Mel Frequency Wrapping
power = abs(f_trans).^2;
power = power(1:NN-1,:);


filters = 20;
f0 = 700/fs;

fmax = fs/2;
nmax = N/2;

df = fs/N;

melmax = 2595 * log10 (1+ fmax/700);
mel2 = melmax / (filters + 1);
melcenters = (1:filters) .* mel2;


fcenters = 700*((10.^(melcenters./2595))-1);

    centerf = round(fcenters./df);

    startf = [1,centerf(1:filters-1)];
    stopf = [centerf(2:filters),nmax];

    W = zeros(filters,nmax);

    % Making filter..
    for i = 1:filters
        increment = 1.0/(centerf(i)-startf(i));
        for j = startf(i):centerf(i)
            W(i,j) = (j-startf(i))*increment;
        end
   
        decrement = 1.0/(stopf(i)-centerf(i));
        for j = centerf(i):stopf(i)
            W(i,j) = (j-centerf(i))*decrement;
        end 
    end
    % Normalising..
    for i = 1:filters
        W(i,:) = W(i,:)/sum(W(i,:));
    end
    
    % (c) Apply mel filters to Power spectrum coeffs..

melPowSpecs = W * power;
final = dct(log(melPowSpecs));
final(1,:) = [];
a = final;
% VQ codebook


end





