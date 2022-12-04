% Carga las dos imágenes en matrices
im1 = imread('img_1.png');
im2 = imread('img_2.png');

% Convierte las imágenes a espacio de color HSV
im1HSV = rgb2hsv(im1);
im2HSV = rgb2hsv(im2);

% Detecta los puntos rojos en las imágenes
% utilizando un rango de valores de tono y saturación
rojoMin = [0, 0.3, 0.3];
rojoMax = [0.1, 1.0, 1.0];
mask1 = (im1HSV(:,:,1) >= rojoMin(1)) & (im1HSV(:,:,1) <= rojoMax(1)) & ...
        (im1HSV(:,:,2) >= rojoMin(2)) & (im1HSV(:,:,2) <= rojoMax(2)) & ...
        (im1HSV(:,:,3) >= rojoMin(3)) & (im1HSV(:,:,3) <= rojoMax(3));
mask2 = (im2HSV(:,:,1) >= rojoMin(1)) & (im2HSV(:,:,1) <= rojoMax(1)) & ...
        (im2HSV(:,:,2) >= rojoMin(2)) & (im2HSV(:,:,2) <= rojoMax(2)) & ...
        (im2HSV(:,:,3) >= rojoMin(3)) & (im2HSV(:,:,3) <= rojoMax(3));

% Obtiene la posición de los puntos rojos en las imágenes
[y1, x1] = find(mask1);
[y2, x2] = find(mask2);

% Trianguliza la posición de los puntos rojos en cada imagen
tri1 = delaunay(x1, y1);
tri2 = delaunay(x2, y2);

% Calcula la posición en el espacio de los puntos rojos
% utilizando la triangulización de las dos imágenes
[x, y, z] = triangulate(x1, y1, x2, y2, tri1, tri2);

% Dibuja la posición en el espacio de los puntos rojos
scatter3(x, y, z);
