# DeblurImages

Blur Introduction 
A circular averaging filter is chosen to be the PSF using the fspecial function and specifying ‘disk’, which creates a predefined 2-D filter. Three radii of sizes 5, 10, and 20 were tested. Blur is introduced by convolving the image with the circular average filter through the use of the conv2 command in Matlab.

Noise Introduction
Noise is introduced to an image through the use of the imnoise function from the Image Processing Toolbox. Gaussian noise was chosen in this case, however, the choice was arbitrary. Three noise of variance 10-5, 10-10, and 10-15are tested.

Blur Reduction Through Fourier Transform
The fourier transform of the blurred image was taken using the fft2 command. Using the formula y=h*x in the spatial domain corresponding to Y=HXin the frequency domain, arbitrary H’s, or frequency responses, could be created to deblur the image by the means of X=Y/H. In this case, the blurred image created by the circular averaging filter of 20 was chosen as it introduced the most blurr. Through the use of the frequency response, image was deblurred by conducting the operation Y./H and transformed back to the spatial domain using an inverse Fourier transform through the ifft2 command.

Viewing Frequency Spectra
To view the frequency spectra, the imshow function from the Image Processing Toolbox was used. In addition, the fftshift command was used to center the zero of the spectra to the center. Absolute value and log were taken as the frequencies span several orders of magnitude.

Blur Reduction Through High Pass Filter
An ideal high pass filter was created by zeroing frequencies below a predetermined threshold. As a result, a square of zero is created at the center of the frequency spectra. Three thresholds of 500, 1000, and 1500 were tested. The threshold was determined arbitrarily from the frequency spectra. 

Blur Reduction Through Built in Functions of the Image Processing Toolbox
The blindeconv function is used for reduction. Arbitrary circular averaging filter was again chosen for the operation to serve as the initial estimate of the PSF. Three numbers of iteration were chosen of 5, 10, and 20. 

Blur Reduction of Total Blind Images
All three methods of blur reduction were tested on a “blind” image. Since both the Fourier transform method and blindeconv require an input of an arbitrary PSF to serve as an initial guess, three sizes of circular averaging filter was tested of radius 5, 10, and 20. 

Noise Reduction
Noise reduction was carried out through two methods: averaging filter and median filter. The averaging filter was created using the filter2 function and passing-in an averaging filter using fspecial(‘average’). The median filtering was carried out using medfilt2.
