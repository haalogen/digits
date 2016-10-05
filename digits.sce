//0. Load MorIARTy-toolbox
cd "MorIARTy-toolbox"
exec("loader.sce");
cd ".."


//1. Load images of digits to array of matrices (size=10): 
font = "arial"
img_dig = zeros(10, 45, 30);

for i = 1:10
    img_dig(i,:,:) = im2double(rgb2gray(imread("img/" + font + "_" + ...
                    string(i-1) + ".jpg")));
end

disp( sum(img_dig(5,:,:)) )


//2. Create projectors on digits from 0 to 9:
for i = 1:10
    projector_dig(i) = MCreateProjector(MCreateMosaicShape(img_dig(i, :, :), "grayscale"));
end

//3. Fill the matrix (10x10) of digits' projections on each other:
projection = zeros(10, 10, 45, 30)

for i = 1:10 // images
    for j = 1:10 // projectors
        // projection of i image on j shape
        projection(i, j,:,:) = MProjection(projector_dig(j), img_dig(i,:,:));
    end
end

disp( sum(projection(3, 5,:,:)) )


//4. Create projector on constant field of vision
// constant field with same size as img_dig[i]
chi_x = zeros(size(img_dig(1, :, :))); 
v0 = MCreateMosaicShape(chi_x, "grayscale");
e = MCreateProjector(v0);

disp( e )


//5. Create projections of digits' on constant field vision:
projection_on_v0 = zeros(10, 45, 30);

for i = 1:10
    projection_on_v0(i) = MProjection(e, img_dig(i,:,:));
end

disp (projection_on_v0)
