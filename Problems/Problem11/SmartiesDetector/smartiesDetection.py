import cv2 as cv
import numpy as np

def smartiesDetection(img_bgr,):

    # Get image in HSV 
    img_hsv = cv.cvtColor(img_bgr,cv.COLOR_BGR2HSV)
    # Get image in RGB
    img = cv.cvtColor(img_bgr,cv.COLOR_BGR2RGB)
    h = img_bgr.shape[0]
    w = img_bgr.shape[1]

    ## RED SMARTIES DETECTION USING HSV ##
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

        #cv.imshow("Red smarties", red_smarties_img)
        #cv.waitKey(1)
    red_smarties_gray = cv.cvtColor(red_smarties_img, cv.COLOR_BGR2GRAY)

    ## IMAGE OPENING TO CLOSE RED SMARTIES AREAS DETECTED ##
    kernel = np.ones((10, 10),np.uint8)
    opening = cv.morphologyEx(red_smarties_gray, cv.MORPH_OPEN, kernel)
    #opening_gbr = cv.cvtColor(opening, cv.COLOR_GRAY2BGR)
    #cv.imshow("Opening", opening_gbr)
    #cv.waitKey(1000)

    ## RED SMARTIES EDGE DETECTION WITH CANNY ##
    img_edges = cv.Canny(opening,100,200)

    # Obtain closed contourns from edge detection 
    #img_edges_gbr = cv.cvtColor(img_edges,cv.COLOR_RGB2BGR)
    #cv.imshow("Canny",img_edges_gbr)
    #cv.waitKey(1000)

    smarties_cont, hierarchy = cv.findContours(img_edges, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE)
    img_contourns_bgr = img_bgr.copy()
    cv.drawContours(img_contourns_bgr, smarties_cont, -1, (0,255,0), 3)

    #cv.imshow("Contour",img_contourns_bgr)
    #cv.waitKey(1000)

    # CALCULATE CENTER OF EACH RED SMARTIES

    x = []
    y = []
    smarties_coord = []
    for i in range(len(smarties_cont)):
        # Create a mask image that contains the contour filled in
        cimg = np.zeros_like(img)
        cv.drawContours(cimg, smarties_cont, i, color=255, thickness=-1)
        
        # Access the image pixels and create a 1D numpy array then add to list
        pts = np.where(cimg == 255)
        # Save 
        x.append(int(np.mean(pts[0])))
        y.append(int(np.mean(pts[1])))
        smarties_coord.append([int(np.mean(pts[0])), int(np.mean(pts[1]))])

        #cv.circle(cimg,(int(np.mean(pts[1])),int(np.mean(pts[0]))),5,(0,0,255),5)
        #cv.imshow("Smarties detection",cimg)
        #cv.waitKey(5000)

        pts = []

    img_rect = img_bgr.copy()
    smarties_bb = []
    i = 0
    for c in smarties_cont:
        rect = cv.boundingRect(c)
        print(cv.contourArea(c))
        x_rect,y_rect,w_rect,h_rect = rect
        img_bb = np.zeros((w_rect, h_rect,3),dtype=np.uint8)
        img_bb = img_rect[y_rect:y_rect+h_rect,x_rect:x_rect+w_rect,:]
        smarties_bb.append(img_bb) 
        #cv.imshow("dddd",img_bb)
        #cv.waitKey(1000)
        i = i+1

    return smarties_bb, smarties_coord
    