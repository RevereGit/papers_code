#include "algorithm.h"
#include "ui_algorithm.h"
#include<QDebug>
#include<opencv2/opencv.hpp>
#include<opencv2/core/core.hpp>
#include<opencv2/highgui/highgui.hpp>
using namespace cv;
algorithm::algorithm(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::algorithm)
{
    ui->setupUi(this);
    this->setWindowTitle("算法测试");
    this->setFixedSize(this->size());

    ui->comboBox->addItems(QStringList()<<tr("请选择")<<tr("MSE")<<tr("PSNR")<<tr("SSIM")<<tr("MAD")<<tr("NIQE"));

}

algorithm::~algorithm()
{
    delete ui;
}

void algorithm::on_pushButton_clicked()
{
    ui->textEdit_calc->clear();
}

void algorithm::on_pushButton_2_clicked()
{
    this->close();
    ui->textEdit_calc->clear();
}

void algorithm::on_comboBox_currentIndexChanged(const QString &arg1)
{
    if(arg1=="MSE")
    {
        Mat img1=imread("D:/QtCode/view1.jpg",0);
        Mat img2=imread("D:/QtCode/view2.jpg",0);
        int MN=img1.rows*img1.cols;
        if(!img1.data && img2.data)return;
        long long sum=0;
        for(int i=1;i<img1.rows;i++)
            for(int j=1;j<img1.cols;j++)
            {
                sum+=(img1.at<uchar>(i,j)-img2.at<uchar>(i,j))*(img1.at<uchar>(i,j)-img2.at<uchar>(i,j));
            }
        double MSE=sum/MN;
        //printf("MSE:%d\n",sum);
        qDebug()<<sum;
        ui->textEdit_calc->setText("所得结果为：");
        ui->textEdit_calc->setText(QString::number(MSE, 8, 4));

    }
    if(arg1=="PSNR")
    {
        Mat img1=imread("D:/QtCode/view1.jpg",0);
        Mat img2=imread("D:/QtCode/view2.jpg",0);
        int MN=img1.rows*img1.cols;
        if(!img1.data && img2.data)return;
        long long sum=0;
        for(int i=1;i<img1.rows;i++)
            for(int j=1;j<img1.cols;j++)
            {
                sum+=(img1.at<uchar>(i,j)-img2.at<uchar>(i,j))*(img1.at<uchar>(i,j)-img2.at<uchar>(i,j));
            }
        double MSE=sum/MN;
        double PSNR = 20 * log10(255 / (sqrt(MSE)));
        //printf("MSE:%d\n",sum);
        //qDebug()<<sum;
        ui->textEdit_calc->setText("所得结果为：");
        ui->textEdit_calc->setText(QString::number(PSNR, 8, 4));
    }

    if(arg1=="SSIM")
    {
        Mat i1=imread("D:/QtCode/view1.jpg");
        Mat i2=imread("D:/QtCode/view2.jpg");
        const double C1 = 6.5025, C2 = 58.5225;
        int d = CV_32F;
        Mat I1, I2;
        i1.convertTo(I1, d);
        i2.convertTo(I2, d);
        Mat I1_2 = I1.mul(I1);
        Mat I2_2 = I2.mul(I2);
        Mat I1_I2 = I1.mul(I2);
        Mat mu1, mu2;
        GaussianBlur(I1, mu1, Size(11,11), 1.5);
        GaussianBlur(I2, mu2, Size(11,11), 1.5);
        Mat mu1_2 = mu1.mul(mu1);
        Mat mu2_2 = mu2.mul(mu2);
        Mat mu1_mu2 = mu1.mul(mu2);
        Mat sigma1_2, sigam2_2, sigam12;
        GaussianBlur(I1_2, sigma1_2, Size(11, 11), 1.5);
        sigma1_2 -= mu1_2;

        GaussianBlur(I2_2, sigam2_2, Size(11, 11), 1.5);
        sigam2_2 -= mu2_2;

        GaussianBlur(I1_I2, sigam12, Size(11, 11), 1.5);
        sigam12 -= mu1_mu2;
        Mat t1, t2, t3;
        t1 = 2 * mu1_mu2 + C1;
        t2 = 2 * sigam12 + C2;
        t3 = t1.mul(t2);

        t1 = mu1_2 + mu2_2 + C1;
        t2 = sigma1_2 + sigam2_2 + C2;
        t1 = t1.mul(t2);

        Mat ssim_map;
        divide(t3, t1, ssim_map);
        Scalar mssim = mean(ssim_map);

        double ssim = (mssim.val[0] + mssim.val[1] + mssim.val[2]) /3;
        ui->textEdit_calc->setText(QString::number(ssim, 8, 4));
    }
}
