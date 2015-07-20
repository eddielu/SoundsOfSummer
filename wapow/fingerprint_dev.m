q = imread('pic1.png');
[x, y, z] = size(q);
q1 = q(1:x, 1:y, 1);
fingerprint = fft(q1, [], 2);