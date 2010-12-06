% kate: remove-trailing-space on; replace-trailing-space-save on; indent-width 2; indent-mode normal; syntax matlab; space-indent on;
%  raw = im2double((imread('../data/testbild','tif')));
raw = double((imread('../data/testbild','tif')));
image(raw);
colormap('Gray');
axis off;
pause;

% teil a

image(cut_rect(raw,0.4));
axis off;
pause;

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
axis off;
pause;

image(ifft2(ifftshift(cut_rect(fftshift(fft2(raw)),0.1))));
axis off;
pause;

% teil d
image(ifft2(ifftshift(cut_round(fftshift(fft2(raw)),0.5))));
axis off;
pause;

image(ifft2(ifftshift(cut_round(fftshift(fft2(raw)),0.1))));
axis off;
pause;