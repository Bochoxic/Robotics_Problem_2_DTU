import cv2 as cv
import numpy as np


a_p_max_th = 50 # Area perimeter ratio max threshold to decide if contoured object is a smartie
a_p_min_th = 0  # Area perimeter ratio min threshold to decide if contoured object is a smartie

# RGB Image
img = np.dstack((r,g,b))
h = r.shape[0]
w = r.shape[1]

print("Image shape: ",(img.shape))

# Get image in BGR
img_bgr = cv.cvtColor(img, cv.COLOR_RGB2BGR)
cv.imshow("Original_image",img_bgr)
cv.waitKey(900)

# Get image in HSV 
img_hsv = cv.cvtColor(img_bgr,cv.COLOR_BGR2HSV)
# Get image in Gray 
img_gray = cv.cvtColor(img_bgr, cv.COLOR_BGR2GRAY)
# Get image in RGB
img = cv.cvtColor(img_bgr,cv.COLOR_BGR2RGB)

print((img.shape))
print(img[30][20][0])

red_smarties_img = img_bgr.copy()
for i in range(h):
    for j in range(w):
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

    cv.imshow("Red smarties", red_smarties_img)
    cv.waitKey(1)

red_smarties_gray = cv.cvtColor(red_smarties_img, cv.COLOR_BGR2GRAY)

# Image  opening to close contourns
kernel = np.ones((10, 10),np.uint8)
opening = cv.morphologyEx(red_smarties_gray, cv.MORPH_OPEN, kernel)
opening_gbr = cv.cvtColor(opening, cv.COLOR_GRAY2BGR)
cv.imshow("Opening", opening_gbr)
cv.waitKey(1000)

# Edge detection first approach with canny
img_edges = cv.Canny(opening,100,200)

# Obtain closed contourns from edge detection 
img_edges_gbr = cv.cvtColor(img_edges,cv.COLOR_RGB2BGR)
cv.imshow("Canny",img_edges_gbr)
cv.waitKey(1000)

contours, hierarchy = cv.findContours(img_edges, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
img_contourns_bgr = img_bgr.copy()
cv.drawContours(img_contourns_bgr, contours, -1, (0,255,0), 3)

cv.imshow("Contour approx",img_contourns_bgr)
cv.waitKey(1000)

# Calculate Area/Perimeter Ratio to decide if it is a Smartie and save contourns
ratio_a_p = []
smarties_cont = []

for idx, cont in enumerate(contours):
    area = cv.contourArea(cont)
    perim = cv.arcLength(cont,True)
    if perim != 0:
        ratio = area/perim
        print(ratio)
        if ratio > a_p_min_th and ratio < a_p_max_th:
            smarties_cont.append(cont)

cv.drawContours(img_bgr,smarties_cont, -1, (0,255,0), 3)

# Save hsv values from all detections to detect colour
smarties_h = []
smarties_s = []
smarties_v = []
x = []
y = []
for i in range(len(smarties_cont)):
    # Create a mask image that contains the contour filled in
    cimg = np.zeros_like(img)
    cv.drawContours(cimg, contours, i, color=255, thickness=-1)
    
    # Access the image pixels and create a 1D numpy array then add to list
    pts = np.where(cimg == 255)
    # Save 
    x.append(int(np.mean(pts[0])))
    y.append(int(np.mean(pts[1])))

    cv.circle(cimg,(int(np.mean(pts[1])),int(np.mean(pts[0]))),5,(0,0,255),5)
    cv.imshow("Smarties detection",cimg)
    cv.waitKey(1000)

    smarties_hsv = img_hsv[pts[0], pts[1]]
    sm_h = [item[0] for item in smarties_hsv]
    sm_s = [item[1] for item in smarties_hsv]
    sm_v = [item[2] for item in smarties_hsv]

    smarties_h.append(sm_h)
    smarties_s.append(sm_s)
    smarties_v.append(sm_v)
    pts = []


# Calculate hsv mean values of each contourn
red_smarties = []
red_smart_cont = []
x_red_smarties = []
y_red_smarties = []
for i in range(len(smarties_cont)):
    h_mean = np.mean(np.array(smarties_h[i]))
    s_mean = np.mean(np.array(smarties_s[i]))
    v_mean = np.mean(np.array(smarties_v[i]))

    if ((h_mean > 0 and h_mean < 15) or (h_mean > 160 and h_mean < 180)) and (s_mean > 100 and s_mean < 255) and (v_mean > 20 and v_mean < 255):
        red_smarties.append(1)
        red_smart_cont.append(smarties_cont[i])
        x_red_smarties.append(x[i])
        y_red_smarties.append(y[i])
        cv.circle(img_bgr,(y[i],x[i]),5,(0,255,0),5)
    else:
        red_smarties.append(0)


cv.drawContours(img_bgr, red_smart_cont, -1, (0,0,255), 3)
cv.imshow("Red smarties contours", img_bgr)

cv.waitKey(10000)
