#ifndef MYCLASS_H
#define MYCLASS_H

#include "qserialport.h"
#include <QObject>

class MyClass : public QObject
{
    Q_OBJECT
public:
    explicit MyClass(QObject *parent = nullptr);

public slots:
    Q_INVOKABLE QStringList getSerialData();
    Q_INVOKABLE QString getUserName();
    Q_INVOKABLE void setUserName(const QString &name);
    Q_INVOKABLE QStringList getSerialPortInfo();
    Q_INVOKABLE QString avaibleSerialPorts();
    Q_INVOKABLE bool sendStringData(QString data);
signals:
    void userNameChanged(const QString &name);
    void newMessage(const bool &boolMessage);
private:
    bool anyMessage;
    QString m_data;
    QString m_userName;
    QSerialPort m_serial;
};

#endif // MYCLASS_H
