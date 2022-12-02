import cv2 as cv
import numpy as np

def sort_list(list1, list2):

    zipped_pairs = zip(list2, list1)

    z = [x for _, x in sorted(zipped_pairs)]

    return z

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
        x = int(np.mean(pts[0]))
        y = int(np.mean(pts[1]))
        smarties_coord.append([x, y])

        #cv.circle(cimg,(int(np.mean(pts[1])),int(np.mean(pts[0]))),5,(0,0,255),5)
        #cv.imshow("Smarties detection",cimg)
        #cv.waitKey(5000)

        pts = []

    img_rect = img_bgr.copy()
    smarties_bb = []
    smarties_bb_coord = []
    i = 0
    for c in smarties_cont:
        rect = cv.boundingRect(c)
        x_rect,y_rect,w_rect,h_rect = rect
        img_bb = np.zeros((w_rect, h_rect,3),dtype=np.uint8)
        img_bb = img_rect[y_rect:y_rect+h_rect,x_rect:x_rect+w_rect,:]
        smarties_bb.append(img_bb) 
        smarties_bb_coord.append([x_rect, y_rect])
        #cv.imshow("dddd",img_bb)
        #cv.waitKey(1000)
        i = i+1

    return smarties_bb, smarties_coord, smarties_bb_coord
    


def siftMatching(img1, img2, sift_match_threshold):
    img1 = cv.cvtColor(img1,cv.COLOR_BGR2GRAY)
    img2 = cv.cvtColor(img2,cv.COLOR_BGR2GRAY)

    h = img1.shape[0]
    w = img1.shape[1]

    # Initiate SIFT detector
    sift = cv.SIFT_create()
    # find the keypoints and descriptors with SIFT
    kp1, des1 = sift.detectAndCompute(img1,None)
    kp2, des2 = sift.detectAndCompute(img2,None)
    # BFMatcher with default params
    bf = cv.BFMatcher()
    matches = bf.knnMatch(des1,des2,k=2)
    # Apply ratio test
    good = []
    img1_sift_coord = []
    img2_sift_coord = []

    for m,n in matches:
        if m.distance < sift_match_threshold*n.distance:
            good.append([m])
            x_1 = kp1[m.queryIdx].pt[0]
            y_1 = kp1[m.queryIdx].pt[1]
            img1_sift_coord.append([x_1, y_1])
            cv.circle(img1,(int(kp1[m.queryIdx].pt[0]), int(kp1[m.queryIdx].pt[1])),5,(0, 255, 0), 1)
            x_2 = kp2[m.trainIdx].pt[0]
            y_2 = kp2[m.trainIdx].pt[1]
            img2_sift_coord.append([x_2, y_2])
            cv.circle(img2,(int(kp2[m.trainIdx].pt[0]), int(kp2[m.trainIdx].pt[1])),5,(0, 255, 0), 1)


    # cv.drawMatchesKnn expects list of lists as matches.
    #img3 = cv.drawMatchesKnn(img1,kp1,img2,kp2,good,None,flags=cv.DrawMatchesFlags_NOT_DRAW_SINGLE_POINTS)
    #cv.imshow("Matches", img3)
    #cv.waitKey(5000)

    return img1_sift_coord, img2_sift_coord


def distanceTriangulation(img1_sift_coord, img2_sift_coord, baseline, focal_length, focal_length_x, focal_length_y, cx, cy):

    d = []
    x_dist = []
    y_dist = []
    for i in range(len(img1_sift_coord)):
        # Get X from the optical center of the camera
        x1 = img1_sift_coord[i][0] - cx
        x2 = img2_sift_coord[i][0] - cx

        # Compute disparity (distance between two points)
        disparity = x1-x2
        # Compute depth and the X coordinate in camera coordinates (SR fixed in camera)
        distance = baseline * focal_length / disparity
        d.append(distance)
        x_dist.append(distance / focal_length * (x1 - cx))
        y_dist.append(distance / focal_length_y * (x2 - cy))

    return d, x_dist, y_dist