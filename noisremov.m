close all;
clear; 
%%Load images
img = rgb2gray(imread('mp.jpeg'));
img = im2double(img);

%%create filter
psf = fspecial('disk', 20);

%%blur image by convolving filter with filter
imgb = conv2(img, psf);

%%test a variety of noises
imgbn1 = imnoise(imgb, 'gaussian', 0.00001);
imgbn2 = imnoise(imgb, 'gaussian', 0.0000000001);
imgbn3 = imnoise(imgb, 'gaussian', 0.000000000000001);


%%plot noisy pictures
%figure();
%subplot(1,4,1), imshow(imgb); title('no noise');
%subplot(1,4,2), imshow(imgbn1); title('Noise of variance 10^{-4}');
%subplot(1,4,3), imshow(imgbn2); title('Noise of variance 10^{-7}');
%subplot(1,4,4), imshow(imgbn3); title('Noise of variance 10^{-10}');

%%filter out noise by averaging filter
figure();
Kaverage1 = filter2(fspecial('average',20),imgb)/255;
subplot(2,4,1), imshow(Kaverage1);
Kaverage2 = filter2(fspecial('average',20),imgbn1)/255;
subplot(2,4,2), imshow(Kaverage2);
Kaverage3 = filter2(fspecial('average',20),imgbn2)/255;
subplot(2,4,3), imshow(Kaverage3);
Kaverage4 = filter2(fspecial('average',20),imgbn3)/255;
subplot(2,4,4), imshow(Kaverage4);

%%filter out noise by median filter
figure();
Kmedian1 = medfilt2(imgb);
%subplot(3,2,1), imshow(Kmedian1); title('Noise Var=10^{-5} Not Filtered');
Kmedian2 = medfilt2(imgbn1);
subplot(3,2,1), imshow(imgbn3); title('Noise Var=10^{-15} Not Filtered');
%subplot(3,2,2), imshow(Kmedian2); title('Median Filtered Noise Var=10^{-5}');
Kmedian3 = medfilt2(imgbn2);
%subplot(3,4,3), imshow(Kmedian3); title('Median Filtered Noise Var=10^{-10}');
Kmedian4 = medfilt2(imgbn3);
subplot(3,2,2), imshow(Kmedian4); title('Median Filtered Noise Var=10^{-15}');

%%Use fourier transform to find frequency components
Y1 = fft2(Kmedian1);
Y2 = fft2(Kmedian2);
Y3 = fft2(Kmedian3);
Y4 = fft2(Kmedian4);

%%pad pst to match that of blurred image with zero
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
subplot(4,4,1), imshow(y1deblur); title('no noise (Deblurred)');
%subplot(4,4,2), imshow(y2deblur); title('Noise var=10^{-5} reduced (Deblurred)');
%subplot(4,4,3), imshow(y3deblur); title('Noise var=10^{-10} reduced (Deblurred)');
subplot(4,4,4), imshow(y4deblur); title('Noise var=10^{-15} reduced (Deblurred)');