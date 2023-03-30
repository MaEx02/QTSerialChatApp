#include "myclass.h"
#include "qdebug.h"
#include <QSerialPortInfo>
#include <QSerialPort>
QStringList comPorts;
QSerialPort serialPort;
bool anyMessages;
QList<QSerialPortInfo> ports;
MyClass::MyClass(QObject *parent)
    : QObject(parent)
{
    m_userName = "Mehmet";
    ports = QSerialPortInfo::availablePorts();
    m_serial.setPortName("COM3");
    m_serial.setBaudRate(QSerialPort::Baud9600);
    m_serial.setDataBits(QSerialPort::Data8);
    m_serial.setParity(QSerialPort::NoParity);
    m_serial.setStopBits(QSerialPort::OneStop);
    m_serial.setFlowControl(QSerialPort::NoFlowControl);
    m_serial.open(QSerialPort::ReadWrite);
    connect(&serialPort, &QSerialPort::readyRead, this, &MyClass::getSerialData);
}
QString MyClass::getUserName(){
    return m_userName;
}
void MyClass::setUserName(const QString &name)
{
    if (m_userName != name) {
        m_userName = name;
        emit userNameChanged(m_userName);
    }
}

QString MyClass::avaibleSerialPorts(){
    QString returnString = "";
    foreach (const QSerialPortInfo &portInfo, ports) {
        returnString += "Port Adı: " + portInfo.portName() + "\n";
        returnString += "Açıklama: " + portInfo.description() + "\n";
        returnString += "Seri Numarası: " + portInfo.serialNumber() + "\n";
        returnString += "Sistem Konumu: " + portInfo.systemLocation() + "\n";
        returnString += "------------------------------------------------ \n" ;
    }
    return returnString;
}

bool MyClass::sendStringData(QString data)
{
    if(m_serial.open(QIODevice::ReadWrite)) {
        QByteArray writeData = data.toUtf8();
        m_serial.write(writeData);
        m_serial.flush();
        m_serial.close();
        return true;
    }
    qDebug()<<"true";
    return false;
}
QStringList MyClass::getSerialPortInfo(){
    QStringList list;
    Q_FOREACH(QSerialPortInfo port, QSerialPortInfo::availablePorts()) {
        list.append(port.portName());
    }
    comPorts = list;
    return list;
}
QStringList MyClass::getSerialData(){
     QByteArray data;
    while(!serialPort.atEnd()){
           data = serialPort.readAll();
           qDebug() << "message :" << data;
       }

   m_data = QString::fromUtf8(data);
   QStringList m_list = m_data.split('^');
    return m_list;

}

