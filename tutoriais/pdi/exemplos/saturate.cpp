#include <iostream>
#include <cv.h>
#include <highgui.h>

using namespace cv;
using namespace std;

int main(int, char**){
  double width, height;
  Vec3b val;
  int inc;
  Mat image, hsv, saturated;
 
  image= imread("saturate.png");
  if(!image.data)
    cout << "nao abriu saturate.png" << endl;

  namedWindow("original",WINDOW_AUTOSIZE);
  namedWindow("saturated",WINDOW_AUTOSIZE);

  cvtColor(image, hsv, CV_BGR2HSV);
  imshow("saturated", hsv);
  inc = 50;
  for(int i=0; i<image.rows; i++){
    for(int j=0; j<image.cols; j++){
	  if(hsv.at<Vec3b>(i,j)[1] <= 255 - inc){
		hsv.at<Vec3b>(i,j)[1] += inc;
	  }
	  else{
		hsv.at<Vec3b>(i,j)[1] = 255;
	  }
	}
  }
  cvtColor(hsv, saturated, CV_HSV2BGR);
  
  imshow("original", image);
  waitKey();
  return 0;
}
