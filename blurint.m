close all;
clear; 
%%Load images
img = rgb2gray(imread('mp.jpeg'));
img = im2double(img);

%%create filter
psf1 = fspecial('disk', 5);
psf2 = fspecial('disk', 10);
psf3 = fspecial('disk', 20);

%%blur image by convolving filter with filter
imgb1 = conv2(img, psf1);
imgb2 = conv2(img, psf2);
imgb3 = conv2(img, psf3);

%%plot images
subplot(1,4,1), imshow(img); title('Raw Image');
subplot(1,4,2), imshow(imgb1); title('Blurred (Rad 5)');
subplot(1,4,3), imshow(imgb2); title('Blurred (Rad 10)');
subplot(1,4,4), imshow(imgb3); title('Blurred (Rad 20)');

%%test a variety of noises
imgbn1 = imnoise(imgb, 'gaussian', 0.0001);
imgbn2 = imnoise(imgb, 'gaussian', 0.0000001);
imgbn3 = imnoise(imgb, 'gaussian', 0.0000000001);

%%plot noisy pictures
figure();
subplot(2,4,1), imshow(imgb); title('no noise');
subplot(2,4,2), imshow(imgbn1); title('Noise of variance 10^{-4}');
subplot(2,4,3), imshow(imgbn2); title('Noise of variance 10^{-7}');
subplot(2,4,4), imshow(imgbn3); title('Noise of variance 10^{-10}');

%%Use fourier transform to find frequency components
Y1 = fft2(imgb);
Y2 = fft2(imgbn1);
Y3 = fft2(imgbn2);
Y4 = fft2(imgbn3);

%%pad zeros to correct dimension, imgb = blurred image, psf = arbritary
%%point state function
newh = zeros(size(imgb));
psfsize = size(psf);
newh(1: psfsize(1), 1:psfsize(2))=psf;
H = fft2(newh);

%%Divide Y by H to obtain X, use inverse fourier to return to spatial
%%domain
y1deblur = ifft2(Y1./H);
y2deblur = ifft2(Y2./H);
y3deblur = ifft2(Y3./H);
y4deblur = ifft2(Y4./H);

%%plot deblurred images
figure();
subplot(3,4,1), imshow(y1deblur); title('no noise (Deblurred)');
subplot(3,4,2), imshow(y2deblur); title('Noise of variance 10^{-4} (Deblurred)');
subplot(3,4,3), imshow(y3deblur); title('Noise of variance 10^{-7} (Deblurred)');
subplot(3,4,4), imshow(y4deblur); title('Noise of variance 10^{-10} (Deblurred)');

%%plot magnitude spectra
figure();
Ysize = size(Y1);
subplot(4,2,1),imshow(log(abs(fftshift(Y1))));
subplot(4,2,2),imshow(log(abs(Y1)));




