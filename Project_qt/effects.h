#ifndef EFFECTS_H
#define EFFECTS_H

#include <QWidget>
#include<QFileDialog>
#include<stdlib.h>
#include<string>

namespace Ui {
class Effects;
}

class Effects : public QWidget
{
    Q_OBJECT

public:
    explicit Effects(QWidget *parent = 0);
    ~Effects();
    QString filepath1;
public slots:
    void on_pushButton_o_clicked();

private slots:

     void on_pushButton_4_clicked();

    void on_pushButton_3_clicked();

    void on_pushButton_5_clicked();

    void on_pushButton_6_clicked();

    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

private:
    Ui::Effects *ui;

};

#endif // EFFECTS_H
