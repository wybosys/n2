
#ifndef __N2VALUES_413E577417484C43847B8DCB14C3C9BD_H_INCLUDED
#define __N2VALUES_413E577417484C43847B8DCB14C3C9BD_H_INCLUDED

N2_BEGIN

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
    
    operator bool () const
    {
        return ConstEqual<VALUE, 0>::IVALUE;
    }
};

template <typename T>
class ZeroObject
{
public:
    
    static const T Zero;
};

template <typename T>
const T ZeroObject<T>::Zero = T();

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
    
    static String Format(NSString* fmt, ...);

    // 和标准string之间的转换
    String(::std::string const&);
    operator ::std::string () const;

};

class Regex
: public Object
{
public:
    
    typedef NSRegularExpressionOptions Option;
    
    Regex();
    Regex(String const&, Option = 0);
    
    bool build(String const&, Option = 0);
    
    static Regex& Cached(String const&, Option = 0);
    
};

class Variant
: public Object,
public ZeroObject<Variant>
{
public:
    
    Variant();
    Variant(Number const&);
    Variant(String const&);
    Variant(Object*);
    Variant(Variant const&);
    
    RefPtr<Number> number;
    RefPtr<String> string;
    RefPtr<Object> object;
    
    Variant& operator = (Variant const&);

};

N2_END

#endif
