
import cv2 as cv
import numpy as np
from smartiesDetectionFunctions import *
import statistics

############## PARAMETERS ################

# SIFT
sift_match_threshold = 1

# CAMERA PARAMETERS - mm
baseline = 10
focal_length = 4
focal_length_x = 722.4428
focal_length_y = 723.6033
cx = 322.1767
cy = 257.2320

##########################################


# Read image
img_bgr_1 = cv.imread("img_1.png")

img_bgr_2 = cv.imread("img_2.png")

### BORRAR ESTO CUANDO SE CALIBRE LA CÁMARA ###

h = img_bgr_1.shape[0]
w = img_bgr_1.shape[1]



# Bounding boxes for each red smartie and its center is obtained
smarties_bb_1, smarties_coord_1, smarties_bb_coord_1 = smartiesDetection(img_bgr_1)

smarties_bb_2, smarties_coord_2, smarties_bb_coord_2 = smartiesDetection(img_bgr_2)

cv.circle(img_bgr_1,(int(smarties_bb_coord_1[0][0]), int(smarties_bb_coord_1[0][1])),5,(255,0,0) ,3)
cv.imshow("Check coord bb", img_bgr_1)
cv.waitKey(0)
# Print red smarties detected in both images
for i in range(len(smarties_coord_1)):
    cv.circle(img_bgr_1, (smarties_coord_1[i][1], smarties_coord_1[i][0]),5,(0,255,0),1)

for i in range(len(smarties_coord_2)):
    cv.circle(img_bgr_2, (smarties_coord_2[i][1], smarties_coord_2[i][0]),5,(0,255,0),1)

#cv.imshow("img1", img_bgr_1)
#cv.imshow("img2", img_bgr_2)
#cv.waitKey(0)

# Sort red smarties from both images from left to right
x_1 = []
for i in range(len(smarties_coord_1)):
    x_1.append(smarties_coord_1[i][1])

x_2 = []
for i in range(len(smarties_coord_2)):
    x_2.append(smarties_coord_2[i][1])

smarties_coord_1 = sort_list(smarties_coord_1, x_1)
smarties_bb_1 = sort_list(smarties_bb_1, x_1)

smarties_coord_2 = sort_list(smarties_coord_2, x_2)
smarties_bb_2 = sort_list(smarties_bb_2, x_2)

smarties_bb_coord_1 = sort_list(smarties_bb_coord_1, x_1)
smarties_bb_coord_2 = sort_list(smarties_bb_coord_2, x_2)

# Feature matching between each pair of red smarties
sift_desc_1 = []
sift_desc_2 = []
for i in range(len(smarties_coord_1)):
    desc_1, desc_2 = siftMatching(smarties_bb_1[i], smarties_bb_2[i],sift_match_threshold)
    sift_desc_1.append(desc_1)
    sift_desc_2.append(desc_2)

for i in range(len(sift_desc_1)):
    for j in range(len(sift_desc_1[i])):
        sift_desc_1[i][j][1] = int(sift_desc_1[i][j][1]+smarties_bb_coord_1[i][0])
        sift_desc_1[i][j][0] = int(sift_desc_1[i][j][0]+smarties_bb_coord_1[i][1])
        sift_desc_2[i][j][1] = int(sift_desc_2[i][j][1]+smarties_bb_coord_2[i][0])
        sift_desc_2[i][j][0] = int(sift_desc_2[i][j][0]+smarties_bb_coord_2[i][1])
        
        cv.circle(img_bgr_1,(sift_desc_1[i][j][1], sift_desc_1[i][j][0]),5,(0,255,0),3)
        cv.circle(img_bgr_2,(sift_desc_2[i][j][1], sift_desc_2[i][j][0]),5,(0,255,0),3)



cv.circle(smarties_bb_1[0], (int(sift_desc_1[0][0][1]), int(sift_desc_1[0][0][0])),5,(0,255,0),3)

cv.imshow("Img1", img_bgr_1)
cv.imshow("Img2", img_bgr_2)
cv.waitKey(0)

distance = []
x_dist = []
y_dist = []
for i in range(len(sift_desc_1)):
    d, x, y = distanceTriangulation(sift_desc_1[i], sift_desc_2[i], baseline, focal_length, focal_length_x, focal_length_y, cx, cy)
    distance.append(d)
    x_dist.append(x)
    y_dist.append(y)
print(distance)
d_mean = []
x_mean = []
y_mean = []

for i in range(len(distance)):
    d_mean.append(statistics.mean(distance[i]))
    x_mean.append(statistics.mean(x_dist[i]))
    y_mean.append(statistics.mean(y_dist[i]))

print("\nDist ", d_mean)
print("\n Xdist: ", x_mean)
print("\ny : ", y_mean)
