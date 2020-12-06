clc
clear
% All outputs are images created in folder.
% FOR GRAY SCALE
%Part 1
%Image A
A = rgb2gray(imread('kim.jpg'));
imwrite( A, 'A.jpeg' )

%Image B
B = rgb2gray(imread('self.jpeg'));
% Resize image to same size
[h w]=size(A)
B = imresize(B,[h w]);
imwrite( B, 'B.jpeg' )

% Fourier Transform of A 
ft_A=fftn(A);
%Taking Magnitude of FT of A
r_A= abs(ft_A);
%Taking Inverse FT and shifting so that the zero phase is in the center
ifta_A = ifftshift(ifftn(r_A));
% Converting into int to save as image
ifta_A = uint8(ifta_A);
% Saving as a image
imwrite(ifta_A,'A_Mag.jpeg');
%Taking phase angle of FT of A 
theta_A = angle(ft_A);
% Taking IFt with Magnitude=1 
ifta_A_phase = ifft2(exp(1i*theta_A));

%For observing the real and imaginary part
%ifta_A_phase_real=real(ifta_A_phase);
%ifta_A_phase_complex=imag(ifta_A_phase);
%imshow(ifta_A_phase_complex,[]);


%Scaling of pixels
minVal = min(ifta_A_phase,[],'all');
maxVal = max(ifta_A_phase,[],'all');
mapped_image = (double(ifta_A_phase) - minVal) ./ (maxVal - minVal);
scalemap = size(colormap, 1);
mapped_image = mapped_image .* scalemap;
if scalemap == 2
   mapped_image = mapped_image >= 0.5;  %logical
elseif scalemap <= 256
   mapped_image = uint8(mapped_image);
end

% Saving the reconstruction 
imwrite( mapped_image, 'A_phase.jpeg' )



%Exactly same thing for B

% Fourier Transform of B 
ft_B=fftn(B);
%Taking Magnitude of FT of B
r_B= abs(ft_B);
%Taking Inverse FT and shifting so that the zero phase is in the center
ifta_B = ifftshift(ifftn(r_B));
% Converting into int to save as image
ifta_B = uint8(ifta_B);
% Saving as a image
imwrite(ifta_B,'B_Mag.jpeg');
%Taking phase angle of FT of A 
theta_B = angle(ft_B);
% Taking IFt with Magnitude=1 
ifta_B_phase = ifft2(exp(1i*theta_B));

%For observing the real and imaginary part
%ifta_A_phase_real=real(ifta_A_phase);
%ifta_A_phase_complex=imag(ifta_A_phase);
%imshow(ifta_A_phase_complex,[]);


%Scaling of pixels
minVal = min(ifta_B_phase,[],'all');
maxVal = max(ifta_B_phase,[],'all');
mapped_image = (double(ifta_B_phase) - minVal) ./ (maxVal - minVal);
scalemap = size(colormap, 1);
mapped_image = mapped_image .* scalemap;
if scalemap == 2
   mapped_image = mapped_image >= 0.5;  %logical
elseif scalemap <= 256
   mapped_image = uint8(mapped_image);
end

% Saving the reconstruction 
imwrite( mapped_image, 'B_phase.jpeg' )





%% part 2
%Magnitude of A and Phase of B
R1 = ifft2(r_A.*(exp(1i*theta_B)));
R1 = uint8(R1);
imwrite(R1,'MagAPhaseB.jpeg');

%Magnitude of B and Phase of A
R2 = ifft2(r_B.*(exp(1i*theta_A)));
R2 = uint8(R2);
imwrite(R2,'MagBPhaseA.jpeg');



