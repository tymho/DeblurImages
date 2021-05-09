close all;
clear; 
%%Load images
img = rgb2gray(imread('blurtim.jpg'));
img = im2double(img);

%%create arbritrary filter guess
psf = fspecial('disk', 20);

%%use blind deconv
x = deconvblind(img, psf, 20); 

%%use fourier 
Y1 = fft2(img);
newh = zeros(size(img));
psfsize = size(psf);
newh(1: psfsize(1), 1:psfsize(2))=psf;
H = fft2(newh);
y1deblur = ifft2(Y1./H);

%%taper edge
tape = edgetaper(img, psf);
x_tape = deconvblind(tape, psf, 20); 

%%noise
k = 5;
Ysize = size(fft2(img));
n=Ysize(1);
m=Ysize(2);
Y2 = fft2(img);
Y2n = fftshift(Y2);
array2add = zeros(k);
if n > k && m > k
   Y2n((n/2 - k/2 + 1):(n/2 - k/2 + k), (m/2 - k/2 + 1):(m/2 - k/2 + k)) = array2add;
end
figure();
Y2new = ifftshift(Y2n);
figure();
Ysize = size(Y1);
figure();
subplot(2,2,1),imshow(log(abs(fftshift(Y2n))));
subplot(2,2,2),imshow(log(abs(Y2n)));

%%plot
figure();
subplot(1,4,1), imshow(img); title('Raw');
subplot(1,4,2), imshow(x); title('Deblurred with Built-in');
subplot(1,4,3), imshow(Y2new); title('Deblurred with High Pass');
subplot(1,4,4), imshow(y1deblur); title('Deblurred with Fourier');

%subplot(1,4,3), imshow(x_tape); title('Deblurred with Built-in and Tapered');