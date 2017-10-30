#ifndef DEAMON_H
#define DEAMON_H

#include <QObject>

class Deamon : public QObject
{
    Q_OBJECT
public:
    explicit Deamon(QObject *parent = nullptr);
    Q_INVOKABLE void signIn(const QString &user, const QString &password);
private:
    const QString url = "http://localhost:3001/";
    const QString secret = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lIjoibWVkb3MiLCJpYXQiOjE1MDkwMzc3NTksImV4cCI6MTYwMzczMjE1OX0._DNUGRkdYAjSQqyZIPGP8ivN63G7DTGD8KAUb7VskEs";

signals:
    Q_INVOKABLE void logged(const QString &authtoken);
public slots:
};

#endif // DEAMON_H
