/**
 * Copyright (C) 2015 Deepin Technology Co., Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 **/

#include "mainwindow.h"
#include <QCursor>
#include <QScreen>

OverrideWindow::OverrideWindow(MainWindow *parent)
    :MainWindow(parent)
{
    QSurfaceFormat sformat;
    sformat.setAlphaBufferSize(8);
    this->setFormat(sformat);
    this->setClearBeforeRendering(true);

    this->setFlags(Qt::Popup|Qt::FramelessWindowHint);
}

OverrideWindow::~OverrideWindow()
{
}

MainWindow::MainWindow(QQuickWindow *parent)
    :QQuickWindow(parent)
{

    QSurfaceFormat sformat;
    sformat.setAlphaBufferSize(8);
    this->setFormat(sformat);
    this->setClearBeforeRendering(true);

    connect(qApp, SIGNAL(focusWindowChanged(QWindow*)), this, SLOT(focusChanged(QWindow *)));
    connect(this, SIGNAL(visibilityChanged(QWindow::Visibility)), this, SLOT(visibilityChangedSlot(QWindow::Visibility)));
    connect(this, SIGNAL(screenChanged(QScreen*)), this, SLOT(handlerScreenChanged(QScreen*)));
}

MainWindow::~MainWindow()
{
}

int MainWindow::shadowWidth()
{
    return _shadowWidth;
}

void MainWindow::setShadowWidth(int shadowWidth)
{
    _shadowWidth = shadowWidth;
   qDebug()<<"setting shadow"<< shadowWidth;
    emit shadowWidthChanged(shadowWidth);
}

QPoint MainWindow::getCursorPos()
{
    return QCursor::pos();
}

void MainWindow::focusChanged(QWindow *win)
{
    Q_EMIT windowFocusChanged(win);
}

void MainWindow::handlerScreenChanged(QScreen *s)
{
    if(s == 0)
    {
        Q_EMIT qt5ScreenChanged();
    }
}

void MainWindow::mousePressEvent(QMouseEvent *ev){
    QPointF p = QPointF(ev->x(), ev->y());
    MainWindow::mousePressed(p);
    QQuickWindow::mousePressEvent(ev);
}

void MainWindow::wheelEvent(QWheelEvent *ev) {
    emit wheel(QPointF(ev->x(), ev->y()));
    QQuickWindow::wheelEvent(ev);
}

void MainWindow::visibilityChangedSlot(QWindow::Visibility visibility)
{
    if(visibility != QWindow::Hidden) {
        this->setShadowWidth(_shadowWidth);
    }
}

int MainWindow::getWinId()
{
    return QString("%1").arg(this->winId()).toInt();
}
