CC = gcc
GXX = g++
AR = ar

CFLAGS := -Wall -Werror -std=gnu99 -g -shared -fPIC
LINKFLAGS := -Wl,-undefined -Wl,dynamic_lookup
INCLUDE_PATH := -I/usr/include/lua5.1 \
				-I./src/luawrap/ \
				-I./src/net/

TARGET_FD_POLL = fd_poll.so
SRCS_FD_POLL := src/net/fd_poll.c
SRCS_FD_POLL += src/luawrap/lua_fd_poll.c
OBJS_FD_POLL := $(patsubst %c, %o, $(SRCS_FD_POLL))
all : $(TARGET_FD_POLL)
$(TARGET_FD_POLL): $(OBJS_FD_POLL)
	$(CC) $(CFLAGS) $(OBJS_FD_POLL) -o $@
	@mv $(TARGET_FD_POLL) ./libc
%.o:%.c
	$(CC) -c $(INCLUDE_PATH) $(CFLAGS) $^ -o $@
#.PHONY clean

TARGET_TCP = tcp.so
SRCS_TCP := src/net/tcp.c
SRCS_TCP += src/luawrap/lua_tcp.c
OBJS_TCP := $(patsubst %c, %o, $(SRCS_TCP))
all : $(TARGET_TCP)
$(TARGET_TCP): $(OBJS_TCP)
	$(CC) $(CFLAGS) $(OBJS_TCP) -o $@
	@mv $(TARGET_TCP) ./libc
%.o:%.c
	$(CC) -c $(INCLUDE_PATH) $(CFLAGS) $^ -o $@

TARGET_BUFFER = buffer.so
SRCS_BUFFER := src/luawrap/lua_buffer.c
OBJS_BUFFER := $(patsubst %c, %o, $(SRCS_BUFFER))
all : $(TARGET_BUFFER)
$(TARGET_BUFFER): $(OBJS_BUFFER)
	$(CC) $(CFLAGS) $(OBJS_BUFFER) -o $@
	@mv $(TARGET_BUFFER) ./libc
%.o:%.c
	$(CC) -c $(INCLUDE_PATH) $(CFLAGS) $^ -o $@


TARGET_SIGNAL = signal.so
SRCS_SIGNAL := src/luawrap/lua_signal.c
OBJS_SIGNAL := $(patsubst %c, %o, $(SRCS_SIGNAL))
all : $(TARGET_SIGNAL)
$(TARGET_SIGNAL): $(OBJS_SIGNAL)
	$(CC) $(CFLAGS) $(OBJS_SIGNAL) -o $@
	@mv $(TARGET_SIGNAL) ./libc
%.o:%.c
	$(CC) -c $(INCLUDE_PATH) $(CFLAGS) $^ -o $@


clean:
	rm -f ./libc/$(TARGET_FD_POLL) ./libc/$(TARGET_TCP) ./libc/$(TARGET_BUFFER) ./libc/$(TARGET_SIGNAL)
