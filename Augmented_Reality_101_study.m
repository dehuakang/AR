function Augmented_Reality_101_study
% AR
clear all;
close all;

load cameraParams.mat;

I=imread('CalibrationPics/8.jpg');
[im,newOrigin]=undistortImage(I,cameraParams,'outputview','full');
[pts,boardSize]=detectCheckerboardPoints(im);
scale=20;
worldPoints=generateCheckerboardPoints(boardSize,scale);
[rotationMat,transVect]=extrinsics(pts,worldPoints,cameraParams);
camMat=cameraMatrix(cameraParams,rotationMat,transVect);
cube=Cubic(5*20);
imshow(im);
cube.render(gca,camMat);
