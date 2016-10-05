//////////////////////////////////////////////////
// Grayscale mosaic
//////////////////////////////////////////////////

// Read two images of a cube and an image of a circle
img_cube_1_file = fullpath(MorIARTyPath() + "/images/cube/cube-1.png");
img_cube_1 = im2double(rgb2gray(imread(img_cube_1_file)));
img_cube_2_file = fullpath(MorIARTyPath() + "/images/cube/cube-2.png");
img_cube_2 = im2double(rgb2gray(imread(img_cube_2_file)));
img_circle_file = fullpath(MorIARTyPath() + "/images/cube/circle.png");
img_circle = im2double(rgb2gray(imread(img_circle_file)));

// Create the shape of the 1-st cube image and the projector
shape_cube = MCreateMosaicShape(img_cube_1, "grayscale");
proj_cube = MCreateProjector(shape_cube);

// Calculate projection of the 2-nd cube image onto the shape
proj_of_img_cube_2 = MProjection(proj_cube, img_cube_2);
d = norm(img_cube_2(:) - proj_of_img_cube_2(:));
round(d)
d < 1e-6

// Calculate projection of the circle image onto the shape
proj_of_img_circle = MProjection(proj_cube, img_circle);
d = norm(img_circle(:) - proj_of_img_circle(:));
round(d)
d > 30
dbl_proj_of_img_circle = MProjection(proj_cube, proj_of_img_circle);
d = norm(proj_of_img_circle(:) - dbl_proj_of_img_circle(:));
round(d)
d < 1e-6

// Create the shape of the circle image and the projector
shape_circle = MCreateMosaicShape(img_circle, "grayscale");
proj_circle = MCreateProjector(shape_circle);

// Calculate projection of the 1-st cube image onto the shape
proj_of_img_cube_1 = MProjection(proj_circle, img_cube_1);
d = norm(img_cube_1(:) - proj_of_img_cube_1(:));
round(d)
d > 30
dbl_proj_of_img_cube_1 = MProjection(proj_circle, proj_of_img_cube_1);
d = norm(proj_of_img_cube_1(:) - dbl_proj_of_img_cube_1(:));
round(d)
d < 1e-6
