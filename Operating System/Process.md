# Process Concept

關於 "process" 與 "program" 的概念，用 TLPI 一書中的說明方式：

> a process is an abstract entity, defined by the kernel, to which system resources are allocated in order to execute a program ... A *program* is a file containing a range of information that describes how to construct a process at run time.

一個「行程」是一個作業核心提供的抽象單元，由作業系統負責這個抽象單元所需的各種資源; 而一個「程式」是一個檔案，裡面記錄需要啟動一個執行單元需要的各種資訊，比如「機械碼」「資料」「符號表」「共享函式庫」等等。

## /proc

想要知道一個行程有關的資訊可以在 `/proc` 這個目錄中取得資訊。根據 `man proc` 的內容：

```man
PROC(5)                    Linux Programmer's Manual                   PROC(5)

NAME
       proc - process information pseudo-filesystem

DESCRIPTION
       The  proc filesystem is a pseudo-filesystem which provides an interface
       to kernel data structures.  It is commonly  mounted  at  /proc.   Typi‐
       cally,  it  is  mounted automatically by the system, but it can also be
       mounted manually using a command such as:

           mount -t proc proc /proc

       Most of the files in the proc filesystem are read-only, but some  files
       are writable, allowing kernel variables to be changed.
```

言下之意，`proc` 是一個「虛擬的」檔案系統，用來提供一些核心資料結構的介面。更進一步的功能說明，可以參考 TLPI 一書中：

> In order to provide easier access to kernel information, many modern UNIX implementations provide a `/proc` virtual file system. This file system resides under the /proc directory and contains various files that expose kernel information, allowing processes to conveniently read that information, and change it in some cases,
> using normal file I/O system calls.

簡而言之，`\proc` 出現的動機，是讓使用者在不用直接存取核心資料結構的狀況下，取得各種系統資訊。這個介面的好處是不用知道核心資料結構，也可以讀取這些相關資料，再來核心的資料結構改變時，讀取的方式也可以一致; 另外，讀取這些核心的相關資料時，不需要特權也可以讀取。

在 TLPI 中用的例子是 `init` (pid 1 的那個行程)，但在新的 Linux 中 `init` 已經被 `systemd` 取代。所以進行 `cat /proc/1/status` 時會出現的是 `systemd`：

```shell
$ cat /proc/1/status
Name:	systemd
Umask:	0000
State:	S (sleeping)
Tgid:	1
Ngid:	0
Pid:	1
PPid:	0
TracerPid:	0
Uid:	0	0	0	0
Gid:	0	0	0	0
FDSize:	512
Groups:	 
NStgid:	1
NSpid:	1
NSpgid:	1
NSsid:	1
VmPeak:	  260716 kB
VmSize:	  195484 kB
VmLck:	       0 kB
VmPin:	       0 kB
VmHWM:	    9712 kB
VmRSS:	    9712 kB
RssAnon:	    2972 kB
RssFile:	    6740 kB
RssShmem:	       0 kB
VmData:	   19328 kB
VmStk:	     132 kB
VmExe:	     852 kB
VmLib:	    7224 kB
VmPTE:	     144 kB
VmSwap:	       0 kB
HugetlbPages:	       0 kB
...
```

然後，因為 `proc` 檔案系統中的資訊日趨混雜亂，所以有些與系統本身有關的資訊會移到 `sysfs` 中。如果查 `man 5 sysfs` 的話，會查到以下內容：

```shell
SYSFS(5)                   Linux Programmer's Manual                  SYSFS(5)

NAME
       sysfs - a filesystem for exporting kernel objects

DESCRIPTION
       The sysfs filesystem is a pseudo-filesystem which provides an interface
       to kernel data structures.  (More precisely, the files and  directories
       in  sysfs  provide  a view of the kobject structures defined internally
       within the kernel.)  The files under sysfs  provide  information  about
       devices, kernel modules, filesystems, and other kernel components.

       The  sysfs  filesystem  is  commonly mounted at /sys.  Typically, it is
       mounted automatically by the system, but it can also be  mounted  manu‐
       ally using a command such as:

           mount -t sysfs sysfs /sys

       Many of the files in the sysfs filesystem are read-only, but some files
       are writable, allowing kernel variables to be changed.  To avoid redun‐
       dancy,  symbolic  links  are heavily used to connect entries across the
       filesystem tree.
...
```

會發現根本就是差不多的東西。更詳細的內容可以看 [kernel 的文件](https://www.kernel.org/doc/html/v4.16/admin-guide/sysfs-rules.html)。

## Memory Layout

