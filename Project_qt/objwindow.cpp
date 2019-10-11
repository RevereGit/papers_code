#include "objwindow.h"
#include "ui_objwindow.h"
#include<QFile>
#include<QFileDialog>
#include<QMessageBox>
#include<QDebug>
#include<QDir>
#include<QStringList>
#include<QFileInfoList>
#include<QScreen>

ObjWindow::ObjWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::ObjWindow)
{
    ui->setupUi(this);
    this->setWindowTitle("图像客观质量评价");
    this->setFixedSize(this->size());

    connect(ui->actionA,&QAction::triggered,
            [=]()
              {
                //QImage* img1=new QImage;
                QString path=QFileDialog::getOpenFileName(
                            this,
                            "open",
                            "../",
                            tr("Images(*.png *.jpg *.bmp *.GIF)")
                            );
                //ui->label_read->setPixmap(QPixmap::fromImage(*img1));
                //ui->label_read->setScaledContents(true);
              }
                );
    connect(ui->actionB,&QAction::triggered,
            [=]()
                {
                   QString filename1 = QFileDialog::getSaveFileName(this,tr("Save Image"),"",
                                                             tr("Images (*.png *.bmp *.jpg)")); //选择路径
                   QScreen *screen = QGuiApplication::primaryScreen();
                   screen->grabWindow(ui->label_read->winId()).save(filename1);

                });
    connect(ui->actionC,&QAction::triggered,
            [=]()
                {
                    this->close();
                });

    connect(ui->actionF,&QAction::triggered,
            [=]()
                {
                   w3.show();
                });

    ui->pushButton_ok->setVisible(false);
    //ui->pushButton_3->setVisible(false);
   // ui->pushButton_reset->setVisible(false);
    ui->textEdit->setVisible(false);
    connect(ui->actionD,&QAction::triggered,
            [=]()
                {
                    ui->pushButton_ok->show();
                    //ui->pushButton_reset->show();
                    ui->textEdit->show();
                });
}

ObjWindow::~ObjWindow()
{
    delete ui;
}

void ObjWindow::on_pushButton_clicked()
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
            ui->label_read->setPixmap(QPixmap::fromImage(*img));
            ui->label_read->setScaledContents(true);

        //file.close();
    }


}

void ObjWindow::on_pushButton_2_clicked()
{
    this->close();
    ui->label_read->clear();
}
