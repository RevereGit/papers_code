#ifndef OBJWINDOW_H
#define OBJWINDOW_H

#include <QMainWindow>
#include "algorithm.h"


namespace Ui {
class ObjWindow;
}

class ObjWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit ObjWindow(QWidget *parent = 0);
    ~ObjWindow();

private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

private:
    Ui::ObjWindow *ui;
    algorithm w3;

};

#endif // OBJWINDOW_H
