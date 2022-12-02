import cv2 as cv
import numpy as np


# Parameters
img_factor = 1 # Resize image
a_p_max_th = 50 # Area perimeter ratio max threshold to decide if contoured object is a smartie
a_p_min_th = 0  # Area perimeter ratio min threshold to decide if contoured object is a smartie

# Read image
img_bgr = cv.imread("robot_photos/13.jpeg")
h = img_bgr.shape[0]
w = img_bgr.shape[1]

# Resize image
h_r = int(h*img_factor)
w_r = int(w*img_factor)
img_bgr = cv.resize(img_bgr,(h_r,w_r))

# Get image in HSV 
img_hsv = cv.cvtColor(img_bgr,cv.COLOR_BGR2HSV)
# Get image in Gray 
img_gray = cv.cvtColor(img_bgr, cv.COLOR_BGR2GRAY)
img_gray_gbr = cv.cvtColor(img_gray, cv.COLOR_GRAY2BGR)

# Get image in RGB
img = cv.cvtColor(img_bgr,cv.COLOR_BGR2RGB)

print((img.shape))
print(img[30][20][0])


red_smarties_img = img_bgr.copy()
for i in range(w_r):
    for j in range(h_r):
        red_smarties_img[i,j,0] = 255
        red_smarties_img[i,j,1] = 255
        red_smarties_img[i,j,2] = 255
        h = img_hsv[i,j,0]
        s = img_hsv[i,j,1]
        v = img_hsv[i,j,2]
        if ((h > 0 and h < 15) or (h > 160 and h < 180)) and (s > 100 and s < 255) and (v > 20 and v < 255):
            red_smarties_img[i,j,0] = 0
            red_smarties_img[i,j,1] = 255
            red_smarties_img[i,j,2] =0

    cv.imshow("detect", red_smarties_img)
    cv.waitKey(1)
cv.imshow("smarties", red_smarties_img)
cv.waitKey(5000)

