
# ifndef __VCSAMPLE_D6177EF4F54844EDB301F54E42FD1D61_H_INCLUDED
# define __VCSAMPLE_D6177EF4F54844EDB301F54E42FD1D61_H_INCLUDED

N2SAMPLE_BEGIN

class VSample
: public ui::View
{
public:
    
    VSample();
    
protected:
    
    void onLayout(Rect const&);
    
};

class VCSample
: public ui::Controller<VSample>
{
public:
    
    VCSample();
    
protected:
    
    void onLoaded();
    
};

N2SAMPLE_END

# endif
