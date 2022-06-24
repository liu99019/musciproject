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

    //bool operator<(const Lyric& lyric) const	//重载小于号运算符，用于对歌词按时间标签排序
    //{
        //return lyric.time > time;
    //}
};




#endif // COMMON_H
