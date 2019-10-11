#include "mainwindow.h"
#include "ui_mainwindow.h"
#include<QMenuBar>
#include<QMenu>
#include<QDebug>
#include<QAction>
#include<QDialog>
#include<QMessageBox>
#include<QFileDialog>
#include<QImage>
#include<QLabel>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    this->setFixedSize(this->size());
    this->setWindowTitle("图像加密及质量评价系统");


    //主界面图片
    //ui->label_3->setPixmap(QPixmap("://image/head.jpg"));
    //ui->label_3->setScaledContents(true);

    //设置html
    ui->label_6->setText("<h6><a href=\"https://sit.jxufe.edu.cn\">系统V1.0</a></h6>");
    ui->label_6->setOpenExternalLinks(true);
    //设置样式表
    //ui->label_6->setStyleSheet("QLabel{background-color:blue; border-image:url(://image/main_3.jpg)}");


    connect(ui->actionA,&QAction::triggered,
            [=]()
                {
                    this->close();
                });

    //菜单栏
    QMenuBar *mBar=menuBar();
    QMenu *file=mBar->addMenu("文件");
    QMenu *help=mBar->addMenu("帮助");

    //添加菜单项，添加动作
    QAction *pOpen=file->addAction("打开");
    connect(pOpen,&QAction::triggered,
            [=]()
              {
                QString path=QFileDialog::getOpenFileName(
                            this,
                            "open"
                            "../"
                            );
              }
                );


    file->addSeparator();//添加分割线
    QAction *pSave=file->addAction("保存");
    file->addSeparator();
    //QAction *pOut=file->addAction("退出");
    connect(pSave,&QAction::triggered,
            [=]()
              {
                qDebug()<<"hello";
              }
                );

    //帮助--关于
    QAction *pAbout=help->addAction("关于");
    connect(pAbout,&QAction::triggered,
            [=]()
                {
                    QMessageBox::about(this,"关于","version:1.0");

                }
            );
    //file->addSeparator();//添加分割线
   // QAction *p1Quit=file->addAction("退出");
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    w1.show();
}

void MainWindow::on_pushButton_2_clicked()
{
    w2.show();
}

void MainWindow::on_pushButton_3_clicked()
{
    w4.show();
}

void MainWindow::on_pushButton_5_clicked()
{
    w5.show();
}
