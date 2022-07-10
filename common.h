#ifndef COMMON_H
#define COMMON_H

#include <string>
#include<iostream>
using std::string;

#include <QObject>

struct Time
{
    int min;
    int sec;
    int msec;
};


struct Lyric
{
    Time time;
    string text;
};




#endif // COMMON_H
