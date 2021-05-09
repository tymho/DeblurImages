close all;
clear; 
%%Load images
img = rgb2gray(imread('mp.jpeg'));
img = im2double(img);

%%create filter
psf = fspecial('disk', 20);

%%blur image by convolving filter with filter
imgb = conv2(img, psf);

%%plot images
subplot(1,2,1), imshow(img); title('Raw Image');
subplot(1,2,2), imshow(imgb); title('Blurred Image');

%%Use fourier transform to find frequency components
Y1 = fft2(imgb);

%%plot magnitude spectra
figure();
Ysize = size(Y1);
subplot(2,2,1),imshow(log(abs(fftshift(Y1))));
subplot(2,2,2),imshow(log(abs(Y1)));

Y1n = fftshift(Y1);
%%highpass filter; k = threshold; n = horizontal variable; m = verticle
%%variable; Ysize determined dimension of the fourier transform of image;
%%Y1n is the zero-centered magnitude spectra
k = 500;
n=Ysize(1);
m=Ysize(2);
array2add = zeros(k);
if n > k && m > k
   Y1n((n/2 - k/2 + 1):(n/2 - k/2 + k), (m/2 - k/2 + 1):(m/2 - k/2 + k)) = array2add;
end
figure();
subplot(3,2,1),imshow(log(abs(ifftshift(Y1n)))); title('Frequency Spectra');
subplot(3,2,2),imshow(log(abs(Y1n)));
Y1new = ifftshift(Y1n);

%%noise
imgbn3 = imnoise(imgb, 'gaussian', 0.000000000000001);
Y2 = fft2(imgbn3);
Y2n = fftshift(Y2);
array2add = zeros(k);
if n > k && m > k
   Y2n((n/2 - k/2 + 1):(n/2 - k/2 + k), (m/2 - k/2 + 1):(m/2 - k/2 + k)) = array2add;
end
figure();
subplot(4,2,1),imshow(log(abs(ifftshift(Y2n)))); title('Frequency Spectra');
subplot(4,2,2),imshow(log(abs(Y2n)));
Y2new = ifftshift(Y2n);

%%pad pst to match that of blurred image with zero
newh = zeros(size(imgb));
psfsize = size(psf);
newh(1: psfsize(1), 1:psfsize(2))=psf;
H = fft2(newh);
%%Divide Y by H to obtain X, use inverse fourier to return to spatial
%%domain
y1newdeblur = ifft2(Y1new./H);
y1deblur = ifft2(Y1./H);

%%plot deblurred images
figure();
subplot(4,3,1), imshow(img); title('Raw Image');
subplot(4,3,2), imshow(ifft2(Y1)); title('no noise (Blurred)');
subplot(4,3,3), imshow(ifft2(Y1new)); title('no noise (High-Pass filtered)');

figure();
subplot(5,2,1), imshow(imgbn3); title('noise Var=10^{-15} (Blurred)');
subplot(5,2,2), imshow(ifft2(Y2new)); title('noise Var=10^{-15} (High-Pass filtered)');

