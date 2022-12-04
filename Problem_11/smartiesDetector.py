import cv2 as cv
import numpy as np
from smartiesDetectionFunctions import *
import statistics

############## PARAMETERS ################
# Detection 
close_kernel = 5
open_kernel = 30
# SIFT
sift_match_threshold = 0.7

# CAMERA PARAMETERS - mm
focal_length = 723
focal_length_x = 722.4428
focal_length_y = 723.6033
cx = 322.1767
cy = 257.2320

##########################################


# RGB Image
img_1 = np.dstack((r1,g1,b1))
img_2 = np.dstack((r2,g2,b2))

# Get image in BGR
img_bgr_1 = cv.cvtColor(img_1, cv.COLOR_RGB2BGR)
img_bgr_2 = cv.cvtColor(img_2, cv.COLOR_RGB2BGR)

h = img_bgr_1.shape[0]
w = img_bgr_1.shape[1]
print("smarties detection")
# OBTAIN BOUNDING BOX AND CENTER OF EACH SMARTIES
smarties_bb_1, smarties_coord_1, smarties_bb_coord_1 = smartiesDetection(img_bgr_1, close_kernel, open_kernel)

smarties_bb_2, smarties_coord_2, smarties_bb_coord_2 = smartiesDetection(img_bgr_2, close_kernel, open_kernel)

#cv.circle(img_bgr_1,(int(smarties_bb_coord_1[0][0]), int(smarties_bb_coord_1[0][1])),5,(255,0,0) ,3)
#cv.imshow("Check coord bb", img_bgr_1)
#cv.waitKey(0)
# Print red smarties detected in both images
for i in range(len(smarties_coord_1)):
    cv.circle(img_bgr_1, (smarties_coord_1[i][1], smarties_coord_1[i][0]),5,(0,255,0),1)

for i in range(len(smarties_coord_2)):
    cv.circle(img_bgr_2, (smarties_coord_2[i][1], smarties_coord_2[i][0]),5,(0,255,0),1)

#cv.imshow("img1", img_bgr_1)
#cv.imshow("img2", img_bgr_2)
#cv.waitKey(0)
print("Sorting smarties")
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
print("Distance calculation")
# DISTANCE CALCULATION BY TRIANGULATION OF EACH SMARTIES CENTER
distance = []
x_dist = []
y_dist = []
smarties_coord_final = []
print(len(smarties_coord_1))
print(len(smarties_coord_2))

for i in range(len(smarties_coord_1)):
    d, x, y = distanceTriangulation(smarties_coord_1[i], smarties_coord_2[i], baseline, focal_length, focal_length_x, focal_length_y, cx, cy)

    smarties_coord_final.append([d, (-x/10), (y-24)])
    
print(smarties_coord_final)

