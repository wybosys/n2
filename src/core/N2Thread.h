
# ifndef __N2THREAD_774DFE412A9C4F85B2BEEB605A825E22_H_INCLUDED
# define __N2THREAD_774DFE412A9C4F85B2BEEB605A825E22_H_INCLUDED

N2_BEGIN

INTERFACE(Locking,
          virtual void lock() = 0;
          virtual void unlock() = 0;
          );

class Mutex
: public ILocking
{
public:
    
    Mutex();
    virtual ~Mutex();
    
    virtual void lock();
    virtual void unlock();
    
protected:
    
    void* _h;
};

N2_END

# endif
