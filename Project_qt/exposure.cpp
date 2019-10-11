#include "exposure.h"
#include "ui_exposure.h"
#include "addfuction.h"
#include "ui_addfuction.h"
#include<QDebug>

#include<opencv2/opencv.hpp>
#include<opencv2/highgui/highgui.hpp>
#include<opencv2/imgproc/imgproc.hpp>
using namespace cv;


QImage cvMat2QImage2(const cv::Mat& mat)
{
    // 8-bits unsigned, NO. OF CHANNELS = 1
    if(mat.type() == CV_8UC1)
    {
        QImage image(mat.cols, mat.rows, QImage::Format_Indexed8);
        // Set the color table (used to translate colour indexes to qRgb values)
        image.setColorCount(256);
        for(int i = 0; i < 256; i++)
        {
            image.setColor(i, qRgb(i, i, i));
        }
        // Copy input Mat
        uchar *pSrc = mat.data;
        for(int row = 0; row < mat.rows; row ++)
        {
            uchar *pDest = image.scanLine(row);
            memcpy(pDest, pSrc, mat.cols);
            pSrc += mat.step;
        }
        return image;
    }
    // 8-bits unsigned, NO. OF CHANNELS = 3
    else if(mat.type() == CV_8UC3)
    {
        // Copy input Mat
        const uchar *pSrc = (const uchar*)mat.data;
        // Create QImage with same dimensions as input Mat
        QImage image(pSrc, mat.cols, mat.rows, mat.step, QImage::Format_RGB888);
        return image.rgbSwapped();
    }
    else if(mat.type() == CV_8UC4)
    {
        qDebug() << "CV_8UC4";
        // Copy input Mat
        const uchar *pSrc = (const uchar*)mat.data;
        // Create QImage with same dimensions as input Mat
        QImage image(pSrc, mat.cols, mat.rows, mat.step, QImage::Format_ARGB32);
        return image.copy();
    }
    else
    {
        qDebug() << "ERROR: Mat could not be converted to QImage.";
        return QImage();
    }
}

exposure::exposure(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::exposure)
{
    ui->setupUi(this);
    this->setWindowTitle("exposure");
    this->setFixedSize(this->size());

    //Mat img=imread();
    //ui->label_pic->setPixmap(QPixmap::fromImage(cvMat2QImage(img)));

    Mat src=imread("D:/QtCode/view1.jpg");
    ui->label_pic->setPixmap(QPixmap::fromImage(cvMat2QImage2(src)));
    ui->label_pic->setScaledContents(true);

    int bins=256;
    int hist_size[]={bins};
    float range[]={0,256};
    const float* ranges[]={range};
    MatND redHist,grayHist,blueHist;
    int channels_r[]={0};

    //红色分量
    calcHist(&src,1,channels_r,Mat(),redHist,1,hist_size,ranges,true,false);
    //绿色分量
    int channels_g[]={1};
    calcHist(&src,1,channels_g,Mat(),grayHist,1,hist_size,ranges,true,false);
    //蓝色
    int channels_b[]={2};
    calcHist(&src,1,channels_b,Mat(),blueHist,1,hist_size,ranges,true,false);

    double maxValue_red,maxValue_green,maxValue_blue;
    minMaxLoc(redHist,0,&maxValue_red,0,0);
    minMaxLoc(grayHist,0,&maxValue_green,0,0);
    minMaxLoc(blueHist,0,&maxValue_blue,0,0);
    int scale=1;
    int histHeight=256;
    Mat histImage=Mat::zeros(histHeight,bins*3,CV_8UC3);

    //绘制
    for(int i=0;i<bins;i++)
    {
        float binValue_red=redHist.at<float>(i);
        float binValue_green=grayHist.at<float>(i);
        float binValue_blue=blueHist.at<float>(i);
        int intensity_red=cvRound(binValue_red*histHeight/maxValue_red);
        int intensity_green=cvRound(binValue_green*histHeight/maxValue_green);
        int intensity_blue=cvRound(binValue_blue*histHeight/maxValue_blue);

        rectangle(histImage,Point(i*scale,histHeight-1),Point((i+1)*scale-1,histHeight-intensity_red),Scalar(255,0,0));
        rectangle(histImage,Point((i+bins)*scale,histHeight-1),Point((i+bins+1)*scale-1,histHeight-intensity_green),Scalar(0,255,0));
        rectangle(histImage,Point((i+bins*2)*scale,histHeight-1),Point((i+bins*2+1)*scale-1,histHeight-intensity_blue),Scalar(0,0,255));


    }
    ui->label_hist->setPixmap(QPixmap::fromImage(cvMat2QImage2(histImage)));
    ui->label_hist->setScaledContents(true);

}

exposure::~exposure()
{
    delete ui;
}

//关闭窗口
void exposure::on_pushButton_2_clicked()
{
    this->close();
    ui->label_pic->clear();
    ui->label_hist->clear();

}

//将主label图片读取到子label
void exposure::on_pushButton_p_clicked()
{
    Mat src=imread(filepath2.toStdString());
    ui->label_pic->setPixmap(QPixmap::fromImage(cvMat2QImage2(src)));
    ui->label_pic->setScaledContents(true);

}

//滑动条
void exposure::on_horizontalSlider_valueChanged(int value)
{

    ui->horizontalSlider->setMinimum(0);
    ui->horizontalSlider->setMaximum(100);
    //ui->horizontalSlider->setValue(50);
    int pos=ui->horizontalSlider->value();
    QString str=QString("%1").arg(pos);
    ui->label_hist->setText(str);

}
