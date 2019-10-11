#include "subwindow.h"
#include "ui_subwindow.h"
#include<QMessageBox>
#include<QDebug>
SubWindow::SubWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::SubWindow)
{
    ui->setupUi(this);
    this->setFixedSize(this->size());
    this->setWindowTitle("图像融合主观质量评价");
}

SubWindow::~SubWindow()
{
    delete ui;
}

void SubWindow::on_pushButton_clicked()
{
    QMessageBox::about(this,tr("evaluate"),tr("已评价"));
}

void SubWindow::on_pushButton_2_clicked()
{
    static int i=0;
    ui->stackedWidget->setCurrentIndex(++i%5);
}

void SubWindow::on_pushButton_3_clicked()
{
    this->close();
}

void SubWindow::on_radioButton_clicked()
{
    qDebug()<<"choose picture 1";
}

void SubWindow::on_radioButton_2_clicked()
{
    qDebug()<<"choose picture 2";
}
