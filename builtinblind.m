close all;
clear; 
%%Load images
img = rgb2gray(imread('mp.jpeg'));
img = im2double(img);

%%create filter
psf = fspecial('disk', 20);

%%blur image by convolving filter with filter
imgb = conv2(img, psf);

%%test noise tolerance 
imgbn1 = imnoise(imgb, 'gaussian', 0.0000000001);

%%use blind deconv
x = deconvblind(imgb, psf, 5); 
x_long = deconvblind(imgb, psf, 20); 
x_noise = deconvblind(imgbn1, psf, 5); 
x_noise20 = deconvblind(imgbn1, psf, 20);

figure();
subplot(1,3,1), imshow(imgb); title('Blurred (no noise)');
subplot(1,3,2), imshow(x); title('Deblurred (no noise) Built-in 5 iter');
subplot(1,3,3), imshow(x_long); title('Deblurred (no noise) Built-in 20 iter');

%figure
%subplot(2,3,1), imshow(imgbn1); title('Blurred (Noisy)');
%subplot(2,3,2), imshow(x_noise); title('Deblurred (Noisy) with Built-in 5 iter');
%subplot(2,3,3), imshow(x_noise20); title('Deblurred (Noisy) with Built-in 20 iter');