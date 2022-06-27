#include "mylrc.h"
#include<string>
#include<vector>
#include<fstream>
#include<iostream>
#include<algorithm>
#include"common.h"
#include <QDebug>
#include <iostream>
#include <sstream>

#include <QDebug>
using namespace std;

void MyLrc::beginurl()
{

    cout<<"开始"<<endl;
    //change();
    DivideLyrics();
    DisposeLyric();
    changeTi();
}

void MyLrc::beginstr(QString lrc){

    m_lyrics.clear();
    m_lyrics_str.clear();

    m_str.clear();
    DivideLyrics(lrc);
    DisposeLyric();
    changeTi();
}
int MyLrc::pisotionChange(int m, int s)
{

    //cout<<m<<" "<<s<<endl;
    Time  time;
    time.min=m;
    time.sec=s;

    for (int i{ 0 }; i < m_lyrics.size(); i++)
    {
        if (m_lyrics[i].time.min==time.min&&m_lyrics[i].time.sec==time.sec)
        //if (m_lyrics[i].time.min>time.min)
            return i ;
        if (m_lyrics[i].time.min==time.min&&m_lyrics[i].time.sec>time.sec)
        //if (m_lyrics[i].time.min>time.min)
            return i-1 ;

//        if (time1.min != time2.min)
//            return (time1.min > time2.min);
//        else if (time1.sec != time2.sec)
//            return(time1.sec > time2.sec);
//        else if (time1.msec != time2.msec)
//            return(time1.msec > time2.msec);
//        else return false;


    }
    return m_lyrics.size() ;


}

void MyLrc::bendi(QString name)
{

    cout<<"2";
    qDebug()<<name;

    string newName1;
    string newName2="ddgg;djfkfjkfjdfhgokdjflkdjf;ljkjfkldjkljslkjfld;l";
    newName1=name.toStdString();
    cout<<newName1<<endl;



    cout<<newName1.length()<<endl;
    for(int i=7;i<newName1.length()-3;i++)
    {
        newName2[i-7]=newName1[i];
    }

    newName2[newName1.length()-10]='l';
    newName2[newName1.length()-9]='r';
    newName2[newName1.length()-8]='c';
    newName2[newName1.length()-7]='\0';
    //newName2.size()=newName1.length()-6;
    cout<<newName2<<endl;
    string str(newName2,0,newName1.length()-7);
    cout<<str;
    m_url=str;


    beginurl();


}



MyLrc::MyLrc(QObject *parent)
    : QObject{parent}
{

}

const QString &MyLrc::fileUrl() const
{
    return m_fileUrl;
}

void MyLrc::setFileUrl(const QString &newFileUrl)
{
    if (m_fileUrl == newFileUrl)
        return;
    m_fileUrl = newFileUrl;
    emit fileUrlChanged();
}

const QList<QString> &MyLrc::str() const
{
    return m_str;
}

void MyLrc::setStr(const QList<QString> &newStr)
{
    if (m_str == newStr)
        return;
    m_str = newStr;
    emit strChanged();
}

const QString &MyLrc::fileBy() const
{
    return m_fileBy;
}

void MyLrc::setFileBy(const QString &newFileBy)
{
    if (m_fileBy == newFileBy)
        return;
    m_fileBy = newFileBy;
    emit fileByChanged();
}

const QString &MyLrc::fileAl() const
{
    return m_fileAl;
}

void MyLrc::setFileAl(const QString &newFileAl)
{
    if (m_fileAl == newFileAl)
        return;
    m_fileAl = newFileAl;
    emit fileAlChanged();
}



const QString &MyLrc::fileAr() const
{
    return m_fileAr;
}

void MyLrc::setFileAr(const QString &newFileAr)
{
    if (m_fileAr == newFileAr)
        return;
    m_fileAr = newFileAr;
    emit fileArChanged();
}

const QString &MyLrc::fileTi() const
{
    return m_fileTi;
}

void MyLrc::setFileTi(const QString &newFileTi)
{
    if (m_fileTi == newFileTi)
        return;
    m_fileTi = newFileTi;
    emit fileTiChanged();
}



void MyLrc::DivideLyrics(QString lyrics)
{

        //从歌词文件中获取一行歌词
        std::istringstream input;

        input.str(lyrics.toStdString());

        for(string current_line;std::getline(input, current_line);){
                    m_lyrics_str.push_back(current_line);
        }

}

///
void MyLrc::DivideLyrics()
{
    ///
    //change();

    ifstream openFile;
    //以读的方式打开文件
    openFile.open(m_url,ios::in);

    if (!openFile.is_open()) // 检查文件是否成功打开
        cout << "cannot open file." << endl;
    //else
        //cout << "open it"<< endl;

    //分别保存文件中的每一行数据
    string current_line;

    while (!openFile.eof())
    {
        //从歌词文件中获取一行歌词
        std::getline(openFile, current_line);
        //cout<<current_line<<endl;
        //qDebug()<<"1";
        m_lyrics_str.push_back(current_line);
    }
    openFile.close();
}

void MyLrc::DisposeLyric()
{

    int index;
    string temp;
    Lyric lyric;
    for (int i{ 0 }; i <int( m_lyrics_str.size()); i++)
    {

        ///查找ti ar等标签
        if(m_lyrics_str[0][1]=='t')
{

        if (i==0)
        {
            //查找ti:标签
            index = m_lyrics_str[i].find("ti:");
            int index2 = m_lyrics_str[i].find_first_of(']');

            //string::npos是一个静态成员常量，表示size_t的最大值（Maximum value for size_t）。该值表示“直到字符串结尾”，作为返回值它通常被用作表明没有匹配。
            /*
            substr的函数格式（俗称：字符截取函数）

            格式1： substr(string string, int a, int b);

            格式2：substr(string string, int a) ;

            解析：

                格式1：
                    1、string 需要截取的字符串
                    2、a 截取字符串的开始位置（注：当a等于0或1时，都是从第一位开始截取）
                    3、b 要截取的字符串的长度

                格式2：
                    1、string 需要截取的字符串
                    2、a 可以理解为从第a个字符开始截取后面所有的字符串。
                    */

            if (index != string::npos)temp = m_lyrics_str[i].substr(index + 3, index2 - index - 3);

            m_ti = temp;

            //cout<<temp<<endl;
            i++;
        }



        if (i==1)
        {
            //查找ar:标签
            index = m_lyrics_str[i].find("ar:");
            int index2 = m_lyrics_str[i].find_first_of(']');
            if (index != string::npos)temp = m_lyrics_str[i].substr(index + 3, index2 - index - 3);
            m_ar = temp;
            //cout<<temp<<endl;
            i++;
        }

        if (i==2)
        {
            //查找al:标签
            index = m_lyrics_str[i].find("al:");
            int index2 = m_lyrics_str[i].find_first_of(']');
            if (index != string::npos)temp = m_lyrics_str[i].substr(index + 3, index2 - index - 3);
            m_al = temp;
            //cout<<temp<<endl;
            i++;
        }


        if (i==3)
        {
            //查找by:标签
            index = m_lyrics_str[i].find("by:");
            int index2 = m_lyrics_str[i].find_first_of(']');
            if (index != string::npos)temp = m_lyrics_str[i].substr(index + 3, index2 - index - 3);
            m_by = temp;
            //cout<<temp<<endl;
            i++;
        }

        if (i==4)
        {
            //查找offset:标签
            int temp1 = 0;
            index = m_lyrics_str[i].find("offset:");
            int index2 = m_lyrics_str[i].find_first_of(']');
            if (index != string::npos)temp = m_lyrics_str[i].substr(index + 7, index2 - index - 7);
            //temp1=int(temp);
            m_offset = temp1;
            //cout<<temp<<endl;
            i++;
        }

}


        ///获取歌词文本
        index = m_lyrics_str[i].find_last_of(']');		//查找最后一个']'，后面的字符即为歌词文本
        if (index == string::npos) continue;
        temp = m_lyrics_str[i].substr(index + 1, m_lyrics_str[i].size() - index - 1);
        //将获取到的歌词文本转换成Unicode
        if (temp.empty())		//如果时间标签后没有文本，显示为“……”
            lyric.text = "……";
        else
            lyric.text = temp;
        //cout<<temp<<endl;



        /*
         * [mm:ss] [分钟数::秒钟数]
         * [mm:ss.ff] [分钟数:秒钟数.百分之一秒数]
         * */

        //获取时间标签
        index = -1;
        while (true)
        {
            index = m_lyrics_str[i].find_first_of('[', index + 1);		//查找第1个左中括号
            if (index == string::npos) break;		//没有找到左中括号，退出循环

            else
                if (index > m_lyrics_str[i].size() - 9) break;
            //找到了左中括号，但是左中括号在字符串的倒数第9个字符以后，也退出循环

            else
                    if (m_lyrics_str[i][index + 1]>'9' || m_lyrics_str[i][index + 1] < '0') break;
            //找到了左中括号，但是左中括号后面不是数字，也退出循环


            temp = m_lyrics_str[i].substr(index + 1, 2);//获取时间标签的分钟数
            //cout<<temp<<": ";
            lyric.time.min = atoi(temp.c_str());

            temp = m_lyrics_str[i].substr(index + 4, 2);//获取时间标签的秒钟数
            //cout<<temp<<". ";
            lyric.time.sec = atoi(temp.c_str());

            temp = m_lyrics_str[i].substr(index + 7, 2);//获取时间标签的秒钟数
            //cout<<temp<<" "<<endl;
            lyric.time.msec = atoi(temp.c_str());

            m_lyrics.push_back(lyric);
        }

    }


}




//转换QString和string
void MyLrc::change()
{
    m_url=m_fileUrl.toStdString();
    cout<<m_url;
    //qDebug()<<m_url;
}


//转换string和QString
void MyLrc::changeTi()
{
    m_fileTi=QString::fromStdString(m_ti);
    m_fileAr=QString::fromStdString(m_ar);
    m_fileAl=QString::fromStdString(m_al);
    m_fileBy=QString::fromStdString(m_by);



    //QList<QString> m_str;
    ///QList<int> m_time;
    //m_lyrics;
    for(int i=0;i<m_lyrics.size();i++)
    {
        //cout<<1;
        m_str<<QString::fromStdString(m_lyrics[i].text);
        //cout<<m_lyrics[i].text<<endl;
    }
}


