//0. Load MorIARTy-toolbox
cd "MorIARTy-toolbox"
exec("loader.sce");
cd ".."


//1. Load images of digits to array of matrices (size=10): 
// w=30 h=45 N=10
font = "arial"
img_dig = zeros(45, 30, 10);

//disp ( img_dig(:,:, 1) )

for i = 1:10
    img_dig(:,:,i) = im2double(rgb2gray(imread("img/" + font + "_" +.. 
                     string(i-1) + ".jpg")));
end

//imshow(img_dig(:,:, 1));



//2. Create projectors on digits from 0 to 9:
for i = 1:10
    projector_dig(i) = MCreateProjector(MCreateMosaicShape(img_dig(:, :, i), "grayscale"));
end

//disp( projector_dig(1).shape )
//disp( projector_dig(1).shape.regions )
areas = projector_dig(1).shape.regions / ...
        projector_dig(1).shape.number_of_regions;

//imshow(areas)

//3. Fill the matrix (10x10) of digits' projections on each other:
projection = zeros(45, 30, 10, 10);

for i = 1:10 // images -- columns
    for j = 1:10 // projectors -- rows
        // projection of i image on j shape
        projection(:,:, i, j) = MProjection(projector_dig(j), img_dig(:,:, i));
    end
end

//fig_7_on_5 = imshow( projection(:,:, 6, 8) );


//4. Create projector on constant field of vision
// constant field with same size as img_dig[i]
chi_x = zeros(img_dig(:,:, 1)); 
v0 = MCreateMosaicShape(chi_x, "grayscale");
e = MCreateProjector(v0);

//disp( e.shape )


//5. Create projections of digits' on constant field vision:
projection_on_v0 = zeros(45, 30, 10);

for i = 1:10
    projection_on_v0(:,:, i) = MProjection(e, img_dig(:,:, i));
end

//imshow( projection_on_v0(:, :, 5) )


//6. Carry out experiments TIMES(=33) times
//for images with Gauss noise with mean=0, std=1..MAX_STD(=2) (normal distribution)
TIMES = 30;
av = 0;
HEIGHT = 45;
WIDTH = 30;
MAX_STD = 10;
stds = linspace(0.1, MAX_STD, 20);
STD_LEN = length(stds);
accuracy = zeros(10, STD_LEN);


for idx = 1:10
    mprintf("\ndigit: %d \n", idx-1);
    for ind_std = 1:STD_LEN
        std = stds(ind_std);
        mprintf("std: %f \t", std);
        for t =1:TIMES
            // Making noisy digit
            noise = grand(HEIGHT, WIDTH, "nor", av, std);
//            disp( size(noise) )
//            imshow(noise)
            noisy_dig(:,:, idx) = img_dig(:, :, idx) + noise; // array of noisy digits
        
//        imshow(noisy_dig(:,:, idx)) 
            errors = zeros(10);
        
            g = noisy_dig(:,:, idx);
            eg = MProjection(e, g);
        
            for kdx = 1:10
                pg = MProjection(projector_dig(kdx), g);
                
                foo1 = g - pg;
                foo2 = pg - eg;
                errors(kdx) = norm( foo1(:) ).^2 / norm( foo2(:) ).^2;
            end
            
//            imshow(pg)
        
            // Finding the closest original digit
            [min_val, closest] = min(errors);
            if closest == idx then
                acc = accuracy(idx, ind_std);
                accuracy(idx, ind_std) = acc + 1;
            end

//            disp(errors);
//            disp(min_val, closest-1)
//            plot(0:9, errors, "o")
        end
    end
end

accuracy = accuracy / (1.0*TIMES); 

//disp(accuracy(6, :))


//7. Save accuracy to txt file
//accuracy_dig.dat
//rows -- digits: 0..9
//cols -- standard deviations: 0.1 .. MAX_STD

fname = "accuracy_dig_maxsd" + string(MAX_STD) + "_t" + string(TIMES);
fprintfMat(fname+".dat", accuracy, "%5.2f");


