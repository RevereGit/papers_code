#ifndef ENCRYPTION_H
#define ENCRYPTION_H

#include <QWidget>

namespace Ui {
class encryption;
}

class encryption : public QWidget
{
    Q_OBJECT

public:
    explicit encryption(QWidget *parent = 0);
    ~encryption();

private slots:
    void on_pushButton_2_clicked();

    void on_pushButton_clicked();

private:
    Ui::encryption *ui;
};

#endif // ENCRYPTION_H
