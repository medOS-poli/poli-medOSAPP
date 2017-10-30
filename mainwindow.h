/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#ifndef MainWindow_H
#define MainWindow_H

#include <QQuickItem>
#include <QQuickWindow>
#include <QScreen>

class MainWindow;
class OverrideWindow;

class MainWindow: public QQuickWindow
{
    Q_OBJECT
    Q_DISABLE_COPY(MainWindow)

public:
    MainWindow(QQuickWindow *parent = nullptr);
    ~MainWindow();

    Q_PROPERTY(int shadowWidth READ shadowWidth WRITE setShadowWidth NOTIFY shadowWidthChanged)

    Q_INVOKABLE QPoint getCursorPos();
    Q_INVOKABLE int getWinId();

    //This signal just for Qt5 double screen switch bug
    //When screen switch,
    Q_SIGNAL void qt5ScreenChanged();

    int shadowWidth();
    void setShadowWidth(int);

public slots:
    void focusChanged(QWindow * win);
    void handlerScreenChanged(QScreen* s);

signals:
    void shadowWidthChanged(int shadowWidth);
    void windowFocusChanged(QWindow *window);
    void mousePressed(QPointF point);
    void wheel(QPointF point);

protected:
    virtual void mousePressEvent(QMouseEvent *ev);
    virtual void wheelEvent(QWheelEvent *ev);

private:
    int _shadowWidth;

private slots:
    void visibilityChangedSlot(QWindow::Visibility);
};

class OverrideWindow: public MainWindow
{
    Q_OBJECT
    Q_DISABLE_COPY(OverrideWindow)

public:
    OverrideWindow(MainWindow *parent = 0);
    ~OverrideWindow();

};


#endif // MainWindow_H
