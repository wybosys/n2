
#include "N2Core.h"
#include "N2Values.h"

N2_BEGIN

Number::Number()
{
    
}

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
    return [meta() charValue];
}

Number::operator uchar() const
{
    return [meta() unsignedCharValue];
}

Number::operator short() const
{
    return [meta() shortValue];
}

Number::operator ushort() const
{
    return [meta() unsignedShortValue];
}

Number::operator int() const
{
    return [meta() intValue];
}

Number::operator uint() const
{
    return [meta() unsignedIntValue];
}

Number::operator float() const
{
    return [meta() floatValue];
}

Number::operator double() const
{
    return [meta() doubleValue];
}

Number::operator long() const
{
    return [meta() longValue];
}

Number::operator ulong() const
{
    return [meta() unsignedLongValue];
}

Number::operator longlong() const
{
    return [meta() longLongValue];
}

Number::operator ulonglong() const
{
    return [meta() unsignedLongLongValue];
}

void Number::copy(Number const& r)
{
    setMeta(r.metacopy());
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

String::String(String const& r)
{
    *this = r;
}

String::String(NSMutableString* str)
{
    setMeta(str);
}

String String::operator + (String const& r) const
{
    NSString* m = meta();
    m = [m stringByAppendingString:r];
    return String(m);
}

String& String::operator += (String const& r)
{
    id m = meta();
    if ([m respondsToSelector:@selector(appendString:)])
        [m appendString:r];
    else
        setMeta([m stringByAppendingString:r]);
    return *this;
}

String& String::operator = (String const& r)
{
    setMeta(r.metacopy());
    return *this;
}

bool String::operator == (String const& r) const
{
    return [meta() isEqualToString:r];
}

size_t String::length() const
{
    return [meta() length];
}

void String::copy(String const& r)
{
    setMeta(r.metacopy());
}

String String::Format(NSString *fmt, ...)
{
    va_list va;
    va_start(va, fmt);
    NSString* ret = [[NSString alloc] initWithFormat:fmt arguments:va];
    va_end(va);
    OBJC_CONSIGN(ret);
    return ret;
}

Variant::Variant()
{
    
}

Variant::Variant(Number const& n)
{
    number = RefInstance<Number>();
    number->copy(n);
}

Variant::Variant(String const& s)
{
    string = RefInstance<String>();
    string->copy(s);
}

Variant::Variant(Object* o)
{
    object = o;
}

Variant::Variant(Variant const& r)
{
    if (!r.number.isnull())
    {
        number = RefInstance<Number>();
        number->copy(r.number);
    }

    if (!r.string.isnull())
    {
        string = RefInstance<String>();
        string->copy(r.string);
    }
    
    object = r.object;
}

Variant& Variant::operator = (Variant const& r)
{
    if (!r.number.isnull())
    {
        number = RefInstance<Number>();
        number->copy(r.number);
    }
    else
    {
        number = NULL;
    }
    
    if (!r.string.isnull())
    {
        string = RefInstance<String>();
        string->copy(r.string);
    }
    else
    {
        string = NULL;
    }
    
    object = r.object;
    
    return *this;
}

N2_END
