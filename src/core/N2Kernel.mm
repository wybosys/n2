
#import "N2Kernel.h"

N2_BEGIN

#define PRINT(type) \
printf("%s: ", #type); \
va_list va; \
va_start(va, fmt); \
vprintf(fmt, va); \
va_end(va);

#define FLUSH \
printf("\n"); \
fflush(stdout);

void dlog(char const* fmt, ...)
{
    PRINT(LOGd);
    FLUSH;
}

void dinfo(char const* fmt, ...)
{
    PRINT(INFOd);
    FLUSH;
}

void dwarn(char const* fmt, ...)
{
    PRINT(WARNd);
    FLUSH;
    
    sleep_seconds(3);
}

void dfatal(char const* fmt, ...)
{
    PRINT(FATALd);
    FLUSH;
    
    sleep_seconds(10);
}

void sleep_seconds(float v)
{
    useconds_t sec = v * 1e6;
    usleep(sec);
}

::std::string __typeinfo_name_humaned(::std::string const& str)
{
    return str;
}

N2_END
