
#include "N2Core.h"
#include "N2Values.h"

N2CORE_BEGIN

Number::Number(char v)
{
    setMeta(@(v));
}

Number::Number(int v)
{
    setMeta(@(v));
}

N2CORE_END
