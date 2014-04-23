
#ifndef __N2QC_5E062AB9CD4040E49C625A1D2697FCE4_H_INCLUDED
#define __N2QC_5E062AB9CD4040E49C625A1D2697FCE4_H_INCLUDED

N2_BEGIN

class N2QC
: public Singleton<N2QC>
{
public:
    
    void launch();
    
protected:
    
    N2QC();
    ~N2QC();
    friend class Singleton<N2QC>;
    
    PRIVATE(N2QC);
};

N2_END

#endif
