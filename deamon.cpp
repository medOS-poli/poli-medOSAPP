#include "deamon.h"
#include <QDebug>

#include <QNetworkAccessManager>
#include <QDomDocument>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QEventLoop>
#include <QUrlQuery>
#include <QUrl>
#include <QJsonObject>

Deamon::Deamon(QObject *parent) : QObject(parent)
{

}

void Deamon::signIn(const QString &user, const QString &password)
{

    QUrl mURL("http://localhost:3001/login");

    QJsonObject json;
    json.insert("nick", user);
    json.insert("password", password);

    QNetworkRequest request(mURL);

    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QNetworkAccessManager networkManager;

    QNetworkReply *reply = networkManager.post(request,QJsonDocument(json).toJson());
    QEventLoop loop;

    connect(reply, SIGNAL(finished()), &loop, SLOT(quit()));
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), &loop,
            SLOT(quit()));

    loop.exec();

    QByteArray response_data = reply->readAll();
    QJsonDocument userInfo = QJsonDocument::fromJson(response_data);

    reply->deleteLater();

    qDebug()<<"singing"<< json;
}
