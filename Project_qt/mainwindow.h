#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "subwindow.h"
#include "objwindow.h"
#include "addfuction.h"
#include "encryption.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

    void on_pushButton_3_clicked();

    void on_pushButton_5_clicked(); //图像加密按钮

private:
    Ui::MainWindow *ui;
    SubWindow w1;
    ObjWindow w2;
    addfuction w4;
    encryption w5;
};

#endif // MAINWINDOW_H
