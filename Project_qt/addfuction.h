#ifndef ADDFUCTION_H
#define ADDFUCTION_H

#include <QMainWindow>
#include "effects.h"
#include "exposure.h"

namespace Ui {
class addfuction;
}

class addfuction : public QMainWindow
{
    Q_OBJECT

public:
    explicit addfuction(QWidget *parent = 0);
    ~addfuction();

private slots:
    void on_pushButton_A_clicked();

    void on_pushButton_B_clicked();

    void on_pushButton_open_clicked();

    void on_pushButton_save_clicked();

    void on_pushButton_8_clicked();

    void on_pushButton_13_clicked();

    void on_pushButton_9_clicked();

    void on_pushButton_Fuse_clicked();

    void on_pushButton_Savef_clicked();

    void on_pushButton_5_clicked();

    void on_pushButton_10_clicked();

private:
    Ui::addfuction *ui;
    Effects w5;
    exposure w7;
};

#endif // ADDFUCTION_H
