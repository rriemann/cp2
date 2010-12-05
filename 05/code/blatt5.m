% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
raw = double(imread('../data/testbild.tif','TIF'));
colormap('Gray');

% teil a

image(cut_rect(raw,0.4));
print('../tmp/eins_a.png');

% teil b
a = rand(5,1)
a_fft = fft(a)
a_2 = ifft(a_fft)
%
a_fftshift = fftshift(a)
a_ifftshift = ifftshift(a_fftshift)
%
A = rand(5)
A_fft = fft2(A)
A_2 = ifft2(A_fft)
%
A_fftshift = fftshift(A)
A_ifftshift = ifftshift(A_fftshift)

% teil c
image(ifft2(ifftshift(cut_rect(fftshift(fft2(raw)),0.5))));
print('../tmp/eins_c_0_5.png');

image(ifft2(ifftshift(cut_rect(fftshift(fft2(raw)),0.1))));
print('../tmp/eins_c_0_1.png');

% teil d
image(ifft2(ifftshift(cut_round(fftshift(fft2(raw)),0.5))));
print('../tmp/eins_d_0_5.png');

image(ifft2(ifftshift(cut_round(fftshift(fft2(raw)),0.1))));
print('../tmp/eins_d_0_1.png');