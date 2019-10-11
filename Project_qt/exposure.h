#ifndef EXPOSURE_H
#define EXPOSURE_H

#include <QWidget>
#include<QFileDialog>
#include<stdlib.h>
#include<string>

namespace Ui {
class exposure;
}

class exposure : public QWidget
{
    Q_OBJECT

public:
    explicit exposure(QWidget *parent = 0);
    ~exposure();
    QString filepath2;
public slots:
    void on_pushButton_p_clicked();

private slots:
    void on_pushButton_2_clicked();

    void on_horizontalSlider_valueChanged(int value);

private:
    Ui::exposure *ui;
};

#endif // EXPOSURE_H
