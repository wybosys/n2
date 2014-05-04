
#include "N2Core.h"
#include "N2Values.h"
#include "N2Cache.h"

N2_BEGIN

Number::Number()
{
    
}

Number::Number(char v)
{
    _setMeta(@(v));
}

Number::Number(uchar v)
{
    _setMeta(@(v));
}

Number::Number(short v)
{
    _setMeta(@(v));
}

Number::Number(ushort v)
{
    _setMeta(@(v));
}

Number::Number(int v)
{
    _setMeta(@(v));
}

Number::Number(uint v)
{
    _setMeta(@(v));
}

Number::Number(float v)
{
    _setMeta(@(v));
}

Number::Number(double v)
{
    _setMeta(@(v));
}

Number::Number(long v)
{
    _setMeta(@(v));
}

Number::Number(ulong v)
{
    _setMeta(@(v));
}

Number::Number(longlong v)
{
    _setMeta(@(v));
}

Number::Number(ulonglong v)
{
    _setMeta(@(v));
}

Number::operator char() const
{
    return [_meta() charValue];
}

Number::operator uchar() const
{
    return [_meta() unsignedCharValue];
}

Number::operator short() const
{
    return [_meta() shortValue];
}

Number::operator ushort() const
{
    return [_meta() unsignedShortValue];
}

Number::operator int() const
{
    return [_meta() intValue];
}

Number::operator uint() const
{
    return [_meta() unsignedIntValue];
}

Number::operator float() const
{
    return [_meta() floatValue];
}

Number::operator double() const
{
    return [_meta() doubleValue];
}

Number::operator long() const
{
    return [_meta() longValue];
}

Number::operator ulong() const
{
    return [_meta() unsignedLongValue];
}

Number::operator longlong() const
{
    return [_meta() longLongValue];
}

Number::operator ulonglong() const
{
    return [_meta() unsignedLongLongValue];
}

void Number::copy(Number const& r)
{
    _setMeta(r.metacopy());
}

Data::Data()
{
    
}

Data::Data(NSData* d)
{
    _setMeta(d);
}

Data::Data(NSMutableData* d)
{
    _setMeta(d);
}

String::String()
{
    _setMeta(@"");
}

String::String(NSString* str)
{
    if (str == nil)
        str = @"";
    _setMeta(str);
}

String::String(String const& r)
{
    *this = r;
}

String::String(NSMutableString* str)
{
    _setMeta(str);
}

String String::operator + (String const& r) const
{
    NSString* m = _meta();
    m = [m stringByAppendingString:r];
    return String(m);
}

String& String::operator += (String const& r)
{
    id m = _meta();
    if ([m respondsToSelector:@selector(appendString:)])
        [m appendString:r];
    else
        _setMeta([m stringByAppendingString:r]);
    return *this;
}

String& String::operator = (String const& r)
{
    _setMeta(r.metacopy());
    return *this;
}

bool String::operator == (String const& r) const
{
    return [_meta() isEqualToString:r];
}

size_t String::length() const
{
    return [_meta() length];
}

void String::copy(String const& r)
{
    _setMeta(r.metacopy());
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

String::String(::std::string const& cstr)
{
    NSString* str = [NSString stringWithCString:cstr.c_str() encoding:NSUTF8StringEncoding];
    _setMeta(str);
}

String::operator ::std::string() const
{
    return _meta<NSString>().UTF8String;
}

class RegexCache
: public Singleton<RegexCache>,
public core::ObjectCache
{};

Regex::Regex()
{
    
}

Regex::Regex(String const& pat, Option opt)
{
    NSError* err = nil;
    NSRegularExpression* reg = [[NSRegularExpression alloc] initWithPattern:pat
                                                                    options:opt
                                                                      error:&err];
    _setMeta(reg);
    OBJC_RELEASE(reg);
}

bool Regex::build(String const& pat, Option opt)
{
    NSError* err = nil;
    NSRegularExpression* reg = [[NSRegularExpression alloc] initWithPattern:pat
                                                                    options:opt
                                                                      error:&err];
    _setMeta(reg);
    OBJC_RELEASE(reg);
    return err == nil;
}

Regex& Regex::Cached(String const& pat, Option opt)
{
    Regex& reg = (Regex&)RegexCache::shared().add(pat, [&pat, &opt]() -> RefPtr<ReferenceObject> {
        return (RefPtr<ReferenceObject>)RefInstance<Regex>(pat, opt);
    });
    return reg;
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
