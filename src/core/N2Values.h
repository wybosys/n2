
#ifndef __N2VALUES_413E577417484C43847B8DCB14C3C9BD_H_INCLUDED
#define __N2VALUES_413E577417484C43847B8DCB14C3C9BD_H_INCLUDED

N2_BEGIN

class Number
: public Object,
public Copyable<Number>
{
public:
    
    Number();
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
    
    operator char () const;
    operator uchar () const;
    operator short () const;
    operator ushort () const;
    operator int () const;
    operator uint () const;
    operator float () const;
    operator double () const;
    operator long () const;
    operator ulong () const;
    operator longlong () const;
    operator ulonglong () const;
    
    void copy(Number const&);
    
};

class Data
: public Object
{
public:
    
    Data();
    Data(NSData*);
    Data(NSMutableData*);
    
};

class String
: public Object,
public Copyable<String>
{
public:
  
    String();
    String(NSString*);
    String(NSMutableString*);
    String(String const&);
    
    String operator + (String const&) const;
    String& operator += (String const&);
    String& operator = (String const&);
    bool operator == (String const&) const;
    size_t length() const;
    
    void copy(String const&);
    
};

class Variant
: public Object
{
public:
    
    Variant();
    Variant(Number const&);
    Variant(String const&);
    Variant(Object*);
    
    RefPtr<Number> number;
    RefPtr<String> string;
    RefPtr<Object> object;
    
};

template <int L, int R>
struct ConstEqual
{
    enum { VALUE = false, IVALUE = true};
};

template <int L>
struct ConstEqual<L, L>
{
    enum { VALUE = true, IVALUE = false};
};

template <int V>
struct Const
{    
    enum { VALUE = V };
    
    inline operator bool () const
    {
        return ConstEqual<VALUE, 0>::IVALUE;
    }
};

N2_END

#endif
