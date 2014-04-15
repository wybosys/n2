
#include "N2Core.h"
#include "N2Values.h"

N2CORE_BEGIN

Number::Number(char v)
{
    setMeta(@(v));
}

Number::Number(uchar v)
{
    setMeta(@(v));
}

Number::Number(short v)
{
    setMeta(@(v));
}

Number::Number(ushort v)
{
    setMeta(@(v));
}

Number::Number(int v)
{
    setMeta(@(v));
}

Number::Number(uint v)
{
    setMeta(@(v));
}

Number::Number(float v)
{
    setMeta(@(v));
}

Number::Number(double v)
{
    setMeta(@(v));
}

Number::Number(long v)
{
    setMeta(@(v));
}

Number::Number(ulong v)
{
    setMeta(@(v));
}

Number::Number(longlong v)
{
    setMeta(@(v));
}

Number::Number(ulonglong v)
{
    setMeta(@(v));
}

Number::operator char() const
{
    return [getMeta() charValue];
}

Number::operator uchar() const
{
    return [getMeta() unsignedCharValue];
}

Number::operator short() const
{
    return [getMeta() shortValue];
}

Number::operator ushort() const
{
    return [getMeta() unsignedShortValue];
}

Number::operator int() const
{
    return [getMeta() intValue];
}

Number::operator uint() const
{
    return [getMeta() unsignedIntValue];
}

Number::operator float() const
{
    return [getMeta() floatValue];
}

Number::operator double() const
{
    return [getMeta() doubleValue];
}

Number::operator long() const
{
    return [getMeta() longValue];
}

Number::operator ulong() const
{
    return [getMeta() unsignedLongValue];
}

Number::operator longlong() const
{
    return [getMeta() longLongValue];
}

Number::operator ulonglong() const
{
    return [getMeta() unsignedLongLongValue];
}

Data::Data()
{
    
}

Data::Data(NSData* d)
{
    setMeta(d);
}

Data::Data(NSMutableData* d)
{
    setMeta(d);
    metamutable = true;
}

String::String()
{
    setMeta(@"");
}

String::String(NSString* str)
{
    if (str == nil)
        str = @"";
    setMeta(str);
}

String::String(NSMutableString* str)
{
    setMeta(str);
    metamutable = true;
}

String& String::operator += (String const& r)
{
    if (metamutable)
        [getMeta() appendString:r];
    else
        setMeta([getMeta() stringByAppendingString:r]);
    return *this;
}

size_t String::length() const
{
    return [getMeta() length];
}

Value::Value()
{
    
}

N2CORE_END
