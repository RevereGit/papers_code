#include "addfuction.h"
#include "ui_addfuction.h"
#include<QFile>
#include<QFileDialog>
#include<QMessageBox>
#include<QDebug>
#include<QScreen>
#include<vector>
#include<stdlib.h>
#include<string>
#include<opencv2/opencv.hpp>
#include<opencv2/highgui/highgui.hpp>
#include<opencv2/imgproc/imgproc.hpp>
using namespace cv;

QImage cvMat2QImage(const cv::Mat& mat)
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
cv::Mat QImage2cvMat(QImage image)
{
    cv::Mat mat;
    qDebug() << image.format();
    switch(image.format())
    {
    case QImage::Format_ARGB32:
    case QImage::Format_RGB32:
    case QImage::Format_ARGB32_Premultiplied:
        mat = cv::Mat(image.height(), image.width(), CV_8UC4, (void*)image.constBits(), image.bytesPerLine());
        break;
    case QImage::Format_RGB888:
        mat = cv::Mat(image.height(), image.width(), CV_8UC3, (void*)image.constBits(), image.bytesPerLine());
        cv::cvtColor(mat, mat, CV_BGR2RGB);
        break;
    case QImage::Format_Indexed8:
        mat = cv::Mat(image.height(), image.width(), CV_8UC1, (void*)image.constBits(), image.bytesPerLine());
        break;
    }
    return mat;
}



addfuction::addfuction(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::addfuction)
{
    ui->setupUi(this);
    this->setWindowTitle("附加功能");
    this->setFixedSize(this->size());

    connect(ui->menu_1->menuAction(),&QAction::triggered,
            [=]()
               {
                   ui->stackedWidget->setCurrentIndex(0);
               });
    connect(ui->menu_2->menuAction(),&QAction::triggered,
            [=]()
               {
                   ui->stackedWidget->setCurrentIndex(1);
               });

}

addfuction::~addfuction()
{
    delete ui;
}

//load image A
static String Apath = "";
void addfuction::on_pushButton_A_clicked()
{
    QString path=QFileDialog::getOpenFileName(this,tr("选择图像"),
                                              "../",
                                              tr("Images(*.png *.jpg *.bmp *.GIF)"));
    //qDebug()<<path;
    Apath = path.toStdString();
    if(path.isEmpty()==false)
    {
            //读文件
            QImage* img=new QImage;

            if(!(img->load(path)))
            {
                QMessageBox::information(this,
                                         tr("打开图像失败"),
                                         tr("打开图像失败!"));
                delete img;
                return;
            }
            //显示到编辑区
            ui->label_A->setPixmap(QPixmap::fromImage(*img));
            ui->label_A->setScaledContents(true);
    }
}

//load image B
static String Bpath = "";
void addfuction::on_pushButton_B_clicked()
{
    QString path=QFileDialog::getOpenFileName(this,tr("选择图像"),
                                              "../",
                                              tr("Images(*.png *.jpg *.bmp *.GIF)"));
    Bpath = path.toStdString();

    if(path.isEmpty()==false)
    {
            //读文件
            QImage* img1=new QImage;

            if(!(img1->load(path)))
            {
                QMessageBox::information(this,
                                         tr("打开图像失败"),
                                         tr("打开图像失败!"));
                delete img1;
                return;
            }
            //显示到编辑区
            ui->label_B->setPixmap(QPixmap::fromImage(*img1));
            ui->label_B->setScaledContents(true);
    }
}

//打开文件（美图）
static String Cpath="";
void addfuction::on_pushButton_open_clicked()
{
    QString path=QFileDialog::getOpenFileName(this,tr("选择图像"),
                                              "../",
                                           tr("Images(*.png *.jpg *.bmp *.GIF)"));
    Cpath=path.toStdString();
    if(path.isEmpty()==false)
    {
            //读文件
            QImage* img=new QImage;

            if(!(img->load(path)))
            {
                QMessageBox::information(this,
                                         tr("打开图像失败"),
                                         tr("打开图像失败!"));
                delete img;
                return;
            }
            //显示到编辑区
            ui->label_read1->setPixmap(QPixmap::fromImage(*img));
            ui->label_read1->setScaledContents(true);
    }
}

void addfuction::on_pushButton_save_clicked()
{
    QString filename1 = QFileDialog::getSaveFileName(this,tr("Save Image"),"",
                                                         tr("Images (*.png *.bmp *.jpg)")); //选择路径
    QScreen *screen = QGuiApplication::primaryScreen();
    screen->grabWindow(ui->label_read1->winId()).save(filename1);

}

//旋转
void addfuction::on_pushButton_8_clicked()
{
    Mat src=imread(Cpath);
    double angle=90;
    Point2f center(src.cols/2,src.rows/2);
    Mat rot=getRotationMatrix2D(center,angle,1);
    Rect bbox=RotatedRect(center,src.size(),angle).boundingRect();

    rot.at<double>(0,2)+=bbox.width/2.0-center.x;
    rot.at<double>(1,2)+=bbox.height/2.0-center.y;

    Mat dst;
    warpAffine(src,dst,rot,bbox.size());
    //imshow("dst",dst);


    ui->label_read1->setPixmap(QPixmap::fromImage(cvMat2QImage(dst)));
    ui->label_read1->setScaledContents(true);

}


void addfuction::on_pushButton_13_clicked()
{
    w5.show();
    //QString qs(Cpath);
    w5.filepath1=QString::fromStdString(Cpath);
    //qDebug()<<w5.filepath1;

    w5.on_pushButton_o_clicked();

}
//对换
void addfuction::on_pushButton_9_clicked()
{
    Mat img=imread(Cpath);
    Mat dst(img.size(),img.type());
    Mat map_x;
    Mat map_y;
    map_x.create(img.size(), CV_32FC1);
    map_y.create(img.size(), CV_32FC1);
    for (int i = 0; i < img.rows; ++i)
      for (int j = 0; j < img.cols; ++j)
        {
           //水平镜像
           map_x.at<float>(i, j) = (float)(img.cols - j);
           map_y.at<float>(i, j) = (float)i;
           //垂直镜像
          /*map_x.at<float>(i, j) = (float)j;
            map_y.at<float>(i, j) = (float)(img.rows-i);*/
        }
        //重映射，将变换后像素放到指定位置
   remap(img, dst, map_x, map_y, CV_INTER_LINEAR);
   ui->label_read1->setPixmap(QPixmap::fromImage(cvMat2QImage(dst)));
   ui->label_read1->setScaledContents(true);
}

//融合
void addfuction::on_pushButton_Fuse_clicked()
{
    //QScreen *screen = QGuiApplication::primaryScreen();
    Mat img1=imread(Apath);
    //qDebug()<<"111"<<Apath;
    Mat img2=imread(Bpath);
    Mat image;

    if(!img1.data|!img2.data)
        {
            qDebug()<<"打开图片失败，请检查路径！";
            return;

        }
        //调整img2的大小与img1的大小一致，融合函数addWeighted()要求输入的两个图形尺寸相同
    //resize(img1,img2,img2.size(),CV_INTER_CUBIC);
    float rate=0.5;
    addWeighted(img1,rate,img2,1-rate,0,image);
    ui->label_Fuse->setPixmap(QPixmap::fromImage(cvMat2QImage(image)));
    ui->label_Fuse->setScaledContents(true);


}

void addfuction::on_pushButton_Savef_clicked()
{
    QString filename1 = QFileDialog::getSaveFileName(this,tr("Save Image"),"",
                                                         tr("Images (*.png *.bmp *.jpg)")); //选择路径
        QScreen *screen = QGuiApplication::primaryScreen();
        screen->grabWindow(ui->label_Fuse->winId()).save(filename1);
}

void addfuction::on_pushButton_5_clicked()
{
    this->close();
    ui->label_A->clear();
    ui->label_B->clear();
    ui->label_Fuse->clear();
}

//曝光度
void addfuction::on_pushButton_10_clicked()
{
    w7.show();
    w7.filepath2=QString::fromStdString(Cpath);
    w7.on_pushButton_p_clicked();
}
