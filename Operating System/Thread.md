# Thread

## Fork-Joint Model



## 建立執行緒

使用 `pthread_create` 函數：

```c
NAME
       pthread_create - create a new thread

SYNOPSIS
       #include <pthread.h>

       int pthread_create(pthread_t *thread, const pthread_attr_t *attr,
                          void *(*start_routine) (void *), void *arg);

       Compile and link with -pthread.

DESCRIPTION
       The  pthread_create()  function  starts  a  new  thread  in the calling
       process.  The new thread starts execution by invoking  start_routine();
       arg is passed as the sole argument of start_routine().
```

開始一個執行 `start_routine` 函式的執行緒，而該函數執行時會使用 `arg` 指向的東西作為參數執行。而這邊要注意的是：跟 `fork` 一個不一樣的地方，thread id 並不是當回傳值回傳（而 `fork` 是回傳 process id），而是把 thread id 放在 `thread` 指標指向的區域。`pthread_create` 的回傳值則用來回傳錯誤代表的 error number。如果沒有錯誤，則回傳 0。pthread 系列的函式大多是依照這樣的作法。

而剩下一個 `attr` 是執行緒的屬性。如果沒有特別指定的話，傳 `NULL` 進去就可以了。

## 終止執行緒

繼續把 `man` 往下翻。會看到：

```c
       The new thread terminates in one of the following ways:

       * It  calls  pthread_exit(3),  specifying  an exit status value that is
         available  to  another  thread  in  the  same  process   that   calls
         pthread_join(3).

       * It  returns  from  start_routine().   This  is  equivalent to calling
         pthread_exit(3) with the value supplied in the return statement.

       * It is canceled (see pthread_cancel(3)).

       * Any of the threads in the process calls exit(3), or the  main  thread
         performs  a  return  from main().  This causes the termination of all
         threads in the process.
```

這 4 種結束的狀況中，第 2 個跟第 4 個很好懂。執行到 `start_routine` 的結尾，執行緒就會自己結束，並且把東西回傳。聽起來滿明顯的。而有人呼叫 `exit` 或是整個行程結束，執行緒應該也要跟著結束，聽起來也很正常。剩下第 2 跟第 4。

### pthread_exit

首先，類似於在 `main` 裡面呼叫 `exit` 會結束一個行程，呼叫 `pthread_exit` 會結束一個執行緒。 `man` 裡面的說明是：

```c
NAME
       pthread_exit - terminate calling thread

SYNOPSIS
       #include <pthread.h>

       void pthread_exit(void *retval);

       Compile and link with -pthread.

DESCRIPTION
       The pthread_exit() function terminates the calling thread and returns a
       value via retval that (if the  thread  is  joinable)  is  available  to
       another thread in the same process that calls pthread_join(3).
```

但與 `exit` 不一樣的地方是，`exit` 的參數是個表示 exit status 的數值，而 `pthread_exit` 的參數則是一個指標 `retval`。thread 要回傳的東西，是透過裡面的 `retval` 指標進行傳遞的。但 `man` 裡面提到：

```c
RETURN VALUE
       This function does not return to the caller.

ERRORS
       This function always succeeds.
```

所以呼叫完之後，這個執行緒就結束了，那要怎麼把要回傳的東西傳出去呢？這是透過 `pthread_join` 函數：

```c
NAME
       pthread_join - join with a terminated thread

SYNOPSIS
       #include <pthread.h>

       int pthread_join(pthread_t thread, void **retval);

       Compile and link with -pthread.

DESCRIPTION
       The pthread_join() function waits for the thread specified by thread to
       terminate.  If that thread has already terminated, then  pthread_join()
       returns immediately.  The thread specified by thread must be joinable.
```

這個功能類似 `waitpid`。但不一樣的地方是，如果 `retval` 不為 `NULL`，那麼執行緒呼叫 `pthread_exit` 後傳進去的指標，會被存進 `retval` 這個「指標的指標」中。這樣，父執行緒就可以收到結束。

另外，如果這種「等待一個執行緒結束」的行為可以任意發生的話，有可能會產生 Deadlock，比如說 A 裡面呼叫 `pthread_join(tid_B, NULL)`, B 裡面呼叫 `pthread_join(tid_A, NULL)`。但實際上，當作業系統發現呼叫某個 `pthread_join` 會發生 Deadlock 時，這個呼叫就不會成功，並且回傳

### pthread_cancel

這個是用到 `pthread_cancel` 來取消執行緒但用法比較多，所以就先省略。

## 一些比較

一些跟 `fork`, `wait` 等等用來建立行程的函式不一樣的地方是：

1. 同一個行程間的執行緒是對等的，沒有父子關係：這個在 `man` 裡面有提到：

   ```c
          All of the threads in a process are peers: any thread can join with any
          other thread in the process.
   ```

   比如說 A 執行序可以創造 B 執行序，但 B 執行序可以反過來等 A 執行緒(也就是進行 `pthread_joint(tid_a, NULL)` 之類的)。但在 process 間運作時，`fork` 出來的執行緒是沒有辦法 `wait` 父執行緒的。

2. `waitpid` 可以設定成「等待任何一個子行程」，但 `pthread_join` 沒辦法做到「等待任何一個執行緒」，只能等自己知道的執行緒。`man` 裡面對應的說明：

   ```c
          There is no pthreads analog of waitpid(-1, &status, 0), that is,  "join
          with  any terminated thread".  If you believe you need this functional‐
          ity, you probably need to rethink your application design.
   ```

3. `waitpid` 可以做到 non-blocking 的等待，但執行序無法直接做到（但還是有方法可以做到）。 

