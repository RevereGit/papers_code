#include "encryption.h"
#include "ui_encryption.h"
#include<QFile>
#include<QFileDialog>
#include<QMessageBox>
#include<QDebug>
#include<QDir>
#include<QStringList>
#include<QFileInfoList>
#include<QScreen>

encryption::encryption(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::encryption)
{
    ui->setupUi(this);
}

encryption::~encryption()
{
    delete ui;
}

void encryption::on_pushButton_2_clicked()
{
    QString path=QFileDialog::getOpenFileName(this,tr("选择图像"),
                                              "../",
                                              tr("Images(*.png *.jpg *.bmp *.GIF)"));
    if(path.isEmpty()==false)
    {
        //文件对象
        //QFile file(path);

        //打开文件，只读方式
       // bool isOk=file.open(QIODevice::ReadOnly);

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
            ui->label_enc2->setPixmap(QPixmap::fromImage(*img));
            ui->label_enc2->setScaledContents(true);

        //file.close();
    }
}

void encryption::on_pushButton_clicked()
{
    QString path=QFileDialog::getOpenFileName(this,tr("选择图像"),
                                              "../",
                                              tr("Images(*.png *.jpg *.bmp *.GIF)"));
    if(path.isEmpty()==false)
    {
        //文件对象
        //QFile file(path);

        //打开文件，只读方式
       // bool isOk=file.open(QIODevice::ReadOnly);

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
            ui->label_enc->setPixmap(QPixmap::fromImage(*img));
            ui->label_enc->setScaledContents(true);

        //file.close();
    }
}
