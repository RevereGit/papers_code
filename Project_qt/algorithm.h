#ifndef ALGORITHM_H
#define ALGORITHM_H

#include <QWidget>

namespace Ui {
class algorithm;
}

class algorithm : public QWidget
{
    Q_OBJECT

public:
    explicit algorithm(QWidget *parent = 0);
    ~algorithm();

private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();

    void on_comboBox_currentIndexChanged(const QString &arg1);

private:
    Ui::algorithm *ui;
};

#endif // ALGORITHM_H
