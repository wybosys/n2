
# include "N2Core.h"
# include "N2Thread.h"
# include <pthread.h>

N2_BEGIN

Mutex::Mutex()
{
    _h = malloc(sizeof(pthread_mutex_t));
    (*(pthread_mutex_t*)_h) = PTHREAD_MUTEX_INITIALIZER;
}

Mutex::~Mutex()
{
    pthread_mutex_destroy((pthread_mutex_t*)_h);
    free(_h);
}

void Mutex::lock()
{
    pthread_mutex_t* mtx = (pthread_mutex_t*)_h;
    pthread_mutex_lock(mtx);
}

void Mutex::unlock()
{
    pthread_mutex_t* mtx = (pthread_mutex_t*)_h;
    pthread_mutex_unlock(mtx);
}

N2_END
