#include "effects.h"
#include "ui_effects.h"
#include "addfuction.h"
#include<QDebug>
#include<opencv2/opencv.hpp>
#include<opencv2/core/core.hpp>
#include<opencv2/highgui/highgui.hpp>
#include<opencv2/imgproc/imgproc.hpp>
using namespace cv;


QImage cvMat2QImage1(const Mat& mat)
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
//cv::Mat QImage2cvMat(QImage image)
//{
//    cv::Mat mat;
//    qDebug() << image.format();
//    switch(image.format())
//    {
//    case QImage::Format_ARGB32:
//    case QImage::Format_RGB32:
//    case QImage::Format_ARGB32_Premultiplied:
//        mat = cv::Mat(image.height(), image.width(), CV_8UC4, (void*)image.constBits(), image.bytesPerLine());
//        break;
//    case QImage::Format_RGB888:
//        mat = cv::Mat(image.height(), image.width(), CV_8UC3, (void*)image.constBits(), image.bytesPerLine());
//        cv::cvtColor(mat, mat, CV_BGR2RGB);
//        break;
//    case QImage::Format_Indexed8:
//        mat = cv::Mat(image.height(), image.width(), CV_8UC1, (void*)image.constBits(), image.bytesPerLine());
//        break;
//    }
//    return mat;
//}

Effects::Effects(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Effects)
{
    ui->setupUi(this);
    this->setWindowTitle("Effects");
    this->setFixedSize(this->size());

    //ui->label_eff->setPixmap(QPixmap::fromImage());
}

Effects::~Effects()
{
    delete ui;
}

//灰度图
void Effects::on_pushButton_4_clicked()
{
    Mat src=imread(filepath1.toStdString());

    Mat dst;
    cvtColor(src,dst,CV_BGR2GRAY);
    ui->label_eff->setPixmap(QPixmap::fromImage(cvMat2QImage1(dst)));
    ui->label_eff->setScaledContents(true);
}

//
void Effects::on_pushButton_o_clicked()
{
    Mat src=imread(filepath1.toStdString());
    ui->label_eff->setPixmap(QPixmap::fromImage(cvMat2QImage1(src)));
    ui->label_eff->setScaledContents(true);
}

//二值化
void Effects::on_pushButton_5_clicked()
{
    Mat src=imread(filepath1.toStdString());
    Mat dst;
    cvtColor(src,dst,CV_BGR2GRAY);
    Mat dst1;
    threshold(dst,dst1,100,255,CV_THRESH_BINARY);
    ui->label_eff->setPixmap(QPixmap::fromImage(cvMat2QImage1(dst1)));
    ui->label_eff->setScaledContents(true);
}

//直方图均衡化
void Effects::on_pushButton_6_clicked()
{
    Mat image = imread(filepath1.toStdString());
//        if (image.empty())
//        {
//            std::cout << "打开图片失败,请检查" << std::endl;
//            return -1;
//        }
//        imshow("原图像", image);
    Mat imageRGB[3];
    split(image, imageRGB);
    for (int i = 0; i < 3; i++)
      {
         equalizeHist(imageRGB[i], imageRGB[i]);
      }
    merge(imageRGB, 3, image);
    ui->label_eff->setPixmap(QPixmap::fromImage(cvMat2QImage1(image)));
    ui->label_eff->setScaledContents(true);
}

//确定,将label中的图显示到上一层label中
void Effects::on_pushButton_clicked()
{
    //this->close();


}
//取消
void Effects::on_pushButton_3_clicked()
{
    this->close();

}
//重置
void Effects::on_pushButton_2_clicked()
{
    Mat src=imread(filepath1.toStdString());
    ui->label_eff->setPixmap(QPixmap::fromImage(cvMat2QImage1(src)));
}
