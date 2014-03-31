
#ifndef __N2VALUES_413E577417484C43847B8DCB14C3C9BD_H_INCLUDED
#define __N2VALUES_413E577417484C43847B8DCB14C3C9BD_H_INCLUDED

N2CORE_BEGIN

class Number
: public Object
{
public:
    
    Number(char);
    Number(uchar);
    Number(short);
    Number(ushort);
    Number(int);
    Number(uint);
    Number(float);
    Number(double);
    Number(long);
    Number(ulong);
    Number(longlong);
    Number(ulonglong);
    
};

class String
: public Object
{
public:
    
};

N2CORE_END

#endif
