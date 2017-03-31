clear all
clc
close all
BILLs = {'10' '20' '50' '100' '200' '500' '1000' '2000' '5000' '10000' ...
         '10b' '20b' '50b' '100b' '200b' '500b' '1000b' '2000b' '5000b' '10000b'};
%% Read
SIZE = [150 300];
NumCls = 40;
colorTransform = makecform('srgb2lab');
colorTransformRev = makecform('lab2srgb');
window = [15 30];

% lab = applycform(rgbImage, colorTransform);

B10 = imresize(imread('Bill/10.jpg'), SIZE);
B10_b = imresize(imread('Bill/10b.jpg'), SIZE);

B20 = imresize(imread('Bill/20.jpg'), SIZE);
B20_b = imresize(imread('Bill/20b.jpg'), SIZE);

B50 = imresize(imread('Bill/50.jpg'), SIZE);
B50_b = imresize(imread('Bill/50b.jpg'), SIZE);

B100 = imresize(imread('Bill/100.jpg'), SIZE);
B100_b = imresize(imread('Bill/100b.jpg'), SIZE);

B200 = imresize(imread('Bill/200.jpg'), SIZE);
B200_b = imresize(imread('Bill/200b.jpg'), SIZE);

B500 = imresize(imread('Bill/500.jpg'), SIZE);
B500_b = imresize(imread('Bill/500b.jpg'), SIZE);

B1000 = imresize(imread('Bill/1000.jpg'), SIZE);
B1000_b = imresize(imread('Bill/1000b.jpg'), SIZE);

B2000 = imresize(imread('Bill/2000.jpg'), SIZE);
B2000_b = imresize(imread('Bill/2000b.jpg'), SIZE);

B5000 = imresize(imread('Bill/5000.jpg'), SIZE);
B5000_b = imresize(imread('Bill/5000b.jpg'), SIZE);

B10000 = imresize(imread('Bill/10000.jpg'), SIZE);
B10000_b = imresize(imread('Bill/10000b.jpg'), SIZE);

B10 = reshape(B10, [SIZE(1)*SIZE(2) 3]);
B10_b = reshape(B10_b, [SIZE(1)*SIZE(2) 3]);

B20 = reshape(B20, [SIZE(1)*SIZE(2) 3]);
B20_b = reshape(B20_b, [SIZE(1)*SIZE(2) 3]);

B50 = reshape(B50, [SIZE(1)*SIZE(2) 3]);
B50_b = reshape(B50_b, [SIZE(1)*SIZE(2) 3]);

B100 = reshape(B100, [SIZE(1)*SIZE(2) 3]);
B100_b = reshape(B100_b, [SIZE(1)*SIZE(2) 3]);

B200 = reshape(B200, [SIZE(1)*SIZE(2) 3]);
B200_b = reshape(B200_b, [SIZE(1)*SIZE(2) 3]);

B500 = reshape(B500, [SIZE(1)*SIZE(2) 3]);
B500_b = reshape(B500_b, [SIZE(1)*SIZE(2) 3]);

B1000 = reshape(B1000, [SIZE(1)*SIZE(2) 3]);
B1000_b = reshape(B1000_b, [SIZE(1)*SIZE(2) 3]);

B2000 = reshape(B2000, [SIZE(1)*SIZE(2) 3]);
B2000_b = reshape(B2000_b, [SIZE(1)*SIZE(2) 3]);

B5000 = reshape(B5000, [SIZE(1)*SIZE(2) 3]);
B5000_b = reshape(B5000_b, [SIZE(1)*SIZE(2) 3]);

B10000 = reshape(B10000, [SIZE(1)*SIZE(2) 3]);
B10000_b = reshape(B10000_b, [SIZE(1)*SIZE(2) 3]);

ALL = [B10; B20; B50; B100; B200; B500; B1000; B2000; B5000; B10000; ...
       B10_b; B20_b; B50_b; B100_b; B200_b; B500_b; B1000_b; B2000_b; B5000_b; B10000_b];
   
opts = statset('Display','final');
[IDX,C,sumd,D] = kmeans(double(ALL),NumCls, ...
                    'distance', 'city', ...
                    'emptyaction', 'singleton', ...
                    'Replicates',5,...
                    'Options',opts);


B10_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10 = reshape(IDX(1:SIZE(1)*SIZE(2)),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B10_2(ii, jj, :) = C(IDX10(ii, jj), :);
    end
end
BoW10 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW10(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B10_2))
% figure, imshow(uint8(B10_2))


B10_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10 = reshape(IDX(SIZE(1)*SIZE(2)*10+1: SIZE(1)*SIZE(2)*11), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B10_b_2(ii, jj, :) = C(IDX10(ii, jj), :);
    end
end
BoW10_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW10_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B10_b_2))


B20_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX20 = reshape(IDX(SIZE(1)*SIZE(2)+1: SIZE(1)*SIZE(2)*2),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B20_2(ii, jj, :) = C(IDX20(ii, jj), :);
    end
end
BoW20 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW20(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX20(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B20_2))

B20_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10 = reshape(IDX(SIZE(1)*SIZE(2)*11+1: SIZE(1)*SIZE(2)*12), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B20_b_2(ii, jj, :) = C(IDX10(ii, jj), :);
    end
end
BoW20_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW20_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B20_b_2))



B50_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX50 = reshape(IDX(SIZE(1)*SIZE(2)*2+1: SIZE(1)*SIZE(2)*3),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B50_2(ii, jj, :) = C(IDX50(ii, jj), :);
    end
end
BoW50 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW50(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX50(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B50_2))
% figure, imshow(uint8(B50_2))

B50_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10 = reshape(IDX(SIZE(1)*SIZE(2)*12+1: SIZE(1)*SIZE(2)*13), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B50_b_2(ii, jj, :) = C(IDX10(ii, jj), :);
    end
end
BoW50_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW50_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B50_b_2))




B100_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
% B100_2 = knnsearch(C, double(B100),'k',1,'distance','city');
IDX100 = reshape(IDX(SIZE(1)*SIZE(2)*3+1: SIZE(1)*SIZE(2)*4),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B100_2(ii, jj, :) = C(IDX100(ii, jj), :);
    end
end
BoW100 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW100(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX100(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B100_2))
% figure, imshow(uint8(B20_2))

B100_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10 = reshape(IDX(SIZE(1)*SIZE(2)*13+1: SIZE(1)*SIZE(2)*14), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B100_b_2(ii, jj, :) = C(IDX10(ii, jj), :);
    end
end
BoW100_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW100_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B100_b_2))




B200_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX200 = reshape(IDX(SIZE(1)*SIZE(2)*4+1: SIZE(1)*SIZE(2)*5),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B200_2(ii, jj, :) = C(IDX200(ii, jj), :);
    end
end
BoW200 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW200(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX200(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B200_2))
% figure, imshow(uint8(B20_2))

B200_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10 = reshape(IDX(SIZE(1)*SIZE(2)*14+1: SIZE(1)*SIZE(2)*15), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B200_b_2(ii, jj, :) = C(IDX10(ii, jj), :);
    end
end
BoW200_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW200_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B200_b_2))




B500_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX500 = reshape(IDX(SIZE(1)*SIZE(2)*5+1: SIZE(1)*SIZE(2)*6),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B500_2(ii, jj, :) = C(IDX500(ii, jj), :);
    end
end
BoW500 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW500(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX500(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B500_2))
% figure, imshow(uint8(B20_2))

B500_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX500 = reshape(IDX(SIZE(1)*SIZE(2)*15+1: SIZE(1)*SIZE(2)*16), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B500_b_2(ii, jj, :) = C(IDX500(ii, jj), :);
    end
end
BoW500_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW500_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX500(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B500_b_2))



B1000_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX1000 = reshape(IDX(SIZE(1)*SIZE(2)*6+1: SIZE(1)*SIZE(2)*7),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B1000_2(ii, jj, :) = C(IDX1000(ii, jj), :);
    end
end
BoW1000 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW1000(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX1000(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B1000_2))
% figure, imshow(uint8(B20_2))

B1000_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX1000 = reshape(IDX(SIZE(1)*SIZE(2)*16+1: SIZE(1)*SIZE(2)*17), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B1000_b_2(ii, jj, :) = C(IDX1000(ii, jj), :);
    end
end
BoW1000_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW1000_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX1000(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B1000_b_2))



B2000_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX2000 = reshape(IDX(SIZE(1)*SIZE(2)*7+1: SIZE(1)*SIZE(2)*8),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B2000_2(ii, jj, :) = C(IDX2000(ii, jj), :);
    end
end
BoW2000 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW2000(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX2000(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B2000_2))
% figure, imshow(uint8(B20_2))

B2000_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX2000 = reshape(IDX(SIZE(1)*SIZE(2)*17+1: SIZE(1)*SIZE(2)*18), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B2000_b_2(ii, jj, :) = C(IDX2000(ii, jj), :);
    end
end
BoW2000_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW2000_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX2000(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B2000_b_2))



B5000_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX5000 = reshape(IDX(SIZE(1)*SIZE(2)*8+1: SIZE(1)*SIZE(2)*9),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B5000_2(ii, jj, :) = C(IDX5000(ii, jj), :);
    end
end
BoW5000 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW5000(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX5000(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B5000_2))
% figure, imshow(uint8(B20_2))

B5000_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX5000 = reshape(IDX(SIZE(1)*SIZE(2)*18+1: SIZE(1)*SIZE(2)*19), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B5000_b_2(ii, jj, :) = C(IDX5000(ii, jj), :);
    end
end
BoW5000_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW5000_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX5000(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B5000_b_2))



B10000_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10000 = reshape(IDX(SIZE(1)*SIZE(2)*9+1: SIZE(1)*SIZE(2)*10),[SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B10000_2(ii, jj, :) = C(IDX10000(ii, jj), :);
    end
end
BoW10000 = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW10000(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10000(indx1,indx2)==ii));
        end
    end
end
figure, subplot(2,1,1), imshow(uint8(B10000_2))
% figure, imshow(uint8(B20_2))

B10000_b_2 = uint8(zeros(SIZE(1), SIZE(2), 3));
IDX10000 = reshape(IDX(SIZE(1)*SIZE(2)*19+1: SIZE(1)*SIZE(2)*20), [SIZE(1) SIZE(2)]);
for ii=1:SIZE(1)
    for jj = 1:SIZE(2)
        B10000_b_2(ii, jj, :) = C(IDX10000(ii, jj), :);
    end
end
BoW10000_b = zeros(NumCls*window(1)*window(2), 1);
for k = 1:window(1)
    indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
    for jj = 1:window(2)
        indx2 = (jj-1)*SIZE(2)/window(2)+1:jj*SIZE(2)/window(2);
        for ii = 1:NumCls
            BoW10000_b(((k-1)*window(2)+jj-1)*NumCls+ii) = sum(sum(IDX10000(indx1,indx2)==ii));
        end
    end
end
subplot(2,1,2), imshow(uint8(B10000_b_2))



BoW = [BoW10 BoW20 BoW50 BoW100 BoW200 BoW500 BoW1000 BoW2000 BoW5000 BoW10000 ...
       BoW10_b BoW20_b BoW50_b BoW100_b BoW200_b BoW500_b BoW1000_b BoW2000_b BoW5000_b BoW10000_b]';
   
   
%% Load Test


close all
TestImages = dir('Test/*.jpg');
for jj=1:size(TestImages, 1)
    Test = imresize(imread(['Test/' TestImages(jj).name]), SIZE);
    figure, subplot(2,1,1);imshow(Test);
    Test = applycform(Test, colorTransform);
    Test = reshape(Test, [SIZE(1)*SIZE(2) 3]);
    TestIDX = knnsearch(C, double(Test),'k',1,'distance','city');
    TestIDX = reshape(TestIDX, [SIZE(1) SIZE(2)]);
    BoWTest = zeros(NumCls*window(1)*window(2), 1);
    for k = 1:window(1)
        indx1 = (k-1)*SIZE(1)/window(1)+1:k*SIZE(1)/window(1);
        for j = 1:window(2)
            indx2 = (j-1)*SIZE(2)/window(2)+1:j*SIZE(2)/window(2);
            for ii = 1:NumCls
                BoWTest(((k-1)*window(2)+j-1)*NumCls+ii) = sum(sum(TestIDX(indx1,indx2)==ii));
            end
        end
    end
    [cls dist] = knnsearch(BoW, double(BoWTest'),'k',2,'distance','city');
    title(['picture ' TestImages(jj).name ' recognized as a ' BILLs{cls(1)} 'with dist  ' num2str(dist(1)) ' or ' BILLs{cls(2)} ' bill with dist  ' num2str(dist(2))])
    subplot(2,1,2);imshow(imread(['Bill/' BILLs{cls(1)} '.jpg']));
    display(['picture ' TestImages(jj).name ' recognized as a ' BILLs{cls(1)} ' bill'])
end
