close all;
clear; 
%%Load images
img = rgb2gray(imread('mp.jpeg'));
img = im2double(img);

%%crop image
%targetSize = [2000 2000];
%r = centerCropWindow2d(size(img),targetSize);
%cimg = imcrop(img,r);

%%create filter
%psf = fspecial('disk', 20);

%%create filters
psf1 = fspecial('disk', 5);
psf2 = fspecial('disk', 10);
psf3 = fspecial('disk', 20);

%%blur image by convolving filter with filter
imgb = conv2(img, psf3);

%%plot images
%subplot(1,2,1), imshow(img); title('Raw Image');
%subplot(1,2,2), imshow(imgb); title('Blurred Image');

%%test a variety of noises
imgbn1 = imnoise(imgb, 'gaussian', 0.00001);
imgbn2 = imnoise(imgb, 'gaussian', 0.0000000001);
imgbn3 = imnoise(imgb, 'gaussian', 0.000000000000001);

%%plot noisy pictures
%figure();
subplot(2,4,1), imshow(imgb); title('no noise');
subplot(2,4,2), imshow(imgbn1); title('Noise (var=10^{-5})');
subplot(2,4,3), imshow(imgbn2); title('Noise (var=10^{-10})');
subplot(2,4,4), imshow(imgbn3); title('Noise (var=10^{-15})');

%%Use fourier transform to find frequency components
Y1 = fft2(imgb);
%Y2 = fft2(imgbn1);
%Y3 = fft2(imgbn2);
Y4 = fft2(imgbn3);

%%pad zeros to correct dimension, imgb = blurred image, psf = arbritary
%%point state function
newh1 = zeros(size(imgb));
newh2 = zeros(size(imgb));
newh3 = zeros(size(imgb));
psfsize = size(psf1);
newh1(1: psfsize(1), 1:psfsize(2))=psf1;
H1 = fft2(newh1);

psfsize = size(psf2);
newh2(1: psfsize(1), 1:psfsize(2))=psf2;
H2 = fft2(newh2);

psfsize = size(psf3);
newh3(1: psfsize(1), 1:psfsize(2))=psf3;
H3 = fft2(newh3);

%%Divide Y by H to obtain X, use inverse fourier to return to spatial
%%domain
y1deblur = ifft2(Y1./H1);
y2deblur = ifft2(Y1./H2);
y3deblur = ifft2(Y1./H3);
%y4deblur = ifft2(Y4./H);

y1deblurn = ifft2(Y4./H1);
y2deblurn = ifft2(Y4./H2);
y3deblurn = ifft2(Y4./H3);
%y4deblur = ifft2(Y4./H);

figure();
subplot(3,3,1), imshow(img); title('raw image');
subplot(3,3,2), imshow(y3deblur); title('no noise (Guess PSF rad20)');
subplot(3,3,3), imshow(y3deblurn); title('noise var=10^{-15} (Guess PSF rad20)');

%%plot deblurred images
figure();
subplot(3,4,1), imshow(imgb); title('blurred image');
subplot(3,4,2), imshow(y1deblur); title('no noise deblurred (Guess PSF rad5)');
subplot(3,4,3), imshow(y2deblur); title('no noise deblurred (Guess PSF rad10)');
subplot(3,4,4), imshow(y3deblur); title('no noise deblurred (Guess PSF rad20)');
%subplot(3,4,3), imshow(y3deblur); title('Noise var=10^{-10} (Deblurred)');
%subplot(3,4,4), imshow(y4deblur); title('Noise var=10^{-20} (Deblurred)');

%%plot deblurred images with noise
%figure();
%subplot(4,4,1), imshow(img); title('raw image');
%subplot(4,4,2), imshow(y1deblurn); title('noise (Guess PSF rad5)');
%subplot(4,4,3), imshow(y2deblurn); title('noise (Guess PSF rad10)');
%subplot(4,4,4), imshow(y3deblurn); title('noise (Guess PSF rad20)');

%%plot magnitude spectra
%figure();
%Ysize = size(Y1);
%subplot(4,2,1),imshow(log(abs(fftshift(Y1))));
%subplot(4,2,2),imshow(log(abs(Y1)));





