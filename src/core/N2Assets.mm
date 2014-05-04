
#include "N2Core.h"
#include "N2Assets.h"
#include "N2Objc.h"

N2CORE_BEGIN

PRIVATE_IMPL(Assets)

void init()
{
    bundle = [NSBundle mainBundle];
    respath = [bundle.resourcePath stringByAppendingString:@"/"];
}

void fin()
{
    
}

NSString* imageName(NSString* name)
{
    NSString* ret = nil;
    if ((ret = [bundle pathForResource:name ofType:@"png"]))
        return ret;
    if ((ret = [bundle pathForResource:name ofType:@"jpg"]))
        return ret;
    if ((ret = [bundle pathForResource:name ofType:@"jpeg"]))
        return ret;
    if ((ret = [bundle pathForResource:name ofType:@"bmp"]))
        return ret;
    if ((ret = [bundle pathForResource:name ofType:@"gif"]))
        return ret;
    return ret;
}

NSBundle* bundle;
String respath;

PRIVATE_END

Assets::Assets()
{
    PRIVATE_CONSTRUCT;
}

Assets::~Assets()
{
    PRIVATE_DESTROY;
}

String Assets::file(String const& f) const
{
    return d_ptr->respath + f;
}

String Assets::image(String const& f) const
{
    String ret;
    if (kUIScreenIsRetina)
    {
        // 普通查找
        {
            Regex& rx = Regex::Cached(@"([0-9a-z\\-_]+)$", NSRegularExpressionCaseInsensitive);
            Regex::strings_matched_t result;
            rx.match(f, result);
            if (result.size())
            {
                // 测试大屏幕
                if (kUIScreenSizeType == kUIScreenSize40)
                    ret = d_ptr->imageName(f + @"-568h@2x");
                
                // 测试普通屏幕
                if (ret.isnull())
                    ret = d_ptr->imageName(f + @"@2x");
            }
        }
        
        // 带 extension 的分段查找
        {
            Regex& rx = Regex::Cached(@"([0-9a-z\\-_]+)\\.([0-9a-z]+)$", NSRegularExpressionCaseInsensitive);
            Regex::strings_matched_t result;
            rx.match(f, result);
            if (result.size())
            {
                String fn = result[0][1];
                String ext = result[0][2];
                
                // 测试大屏幕
                if (kUIScreenSizeType == kUIScreenSize40)
                    ret = d_ptr->imageName(fn + @"-568h@2x");
                
                // 测试普通屏幕
                if (ret.isnull())
                    ret = [d_ptr->bundle pathForResource:(fn + @"@2x") ofType:ext];
            }
        }
    }
    
    if (ret.isnull())
        ret = d_ptr->imageName(f);
    
    return ret;
}

N2CORE_END
