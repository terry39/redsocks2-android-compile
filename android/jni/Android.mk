LOCAL_PATH := $(call my-dir)
LOCAL_SHORT_COMMANDS := true

########################################################
## libevent
########################################################

include $(CLEAR_VARS)

LIBEVENT_SOURCES := \
	buffer.c \
	bufferevent.c bufferevent_filter.c \
	bufferevent_openssl.c bufferevent_pair.c bufferevent_ratelim.c \
	bufferevent_sock.c epoll.c \
	epoll_sub.c evdns.c event.c \
    event_tagging.c evmap.c \
	evrpc.c evthread.c \
	evthread_pthread.c evutil.c \
	evutil_rand.c http.c \
	listener.c log.c poll.c \
	select.c signal.c strlcpy.c

LOCAL_MODULE := libevent2
LOCAL_SRC_FILES := $(addprefix libevent2/, $(LIBEVENT_SOURCES))
LOCAL_CFLAGS := -O2 -I$(LOCAL_PATH)/libevent2 \
	-I$(LOCAL_PATH)/libevent2/include \
	-I$(LOCAL_PATH)/openssl/include

include $(BUILD_STATIC_LIBRARY)


########################################################
## OpenSSL
########################################################
include $(CLEAR_VARS)

openssl_subdirs := $(addprefix $(LOCAL_PATH)/openssl/,$(addsuffix /Android.mk, \
	crypto \
	ssl \
	))
include $(openssl_subdirs)


########################################################
## redsocks
########################################################

include $(CLEAR_VARS)
REDSOCKS_PATH := $(LOCAL_PATH)/../../../..
LOCAL_PATH := $(REDSOCKS_PATH)
JNI_PATH := $(LOCAL_PATH)/android/jni/

LOCAL_MODULE:= redsocks2

LOCAL_SRC_FILES := \
    parser.c main.c redsocks.c log.c direct.c ipcache.c autoproxy.c encrypt.c shadowsocks.c http-connect.c \
	socks4.c socks5.c http-relay.c base.c base64.c md5.c http-auth.c utils.c socks5-udp.c shadowsocks-udp.c \
	tcpdns.c

LOCAL_C_INCLUDES := \
	$(JNI_PATH)/libevent2 \
	$(JNI_PATH)/libevent2/android \
	$(JNI_PATH)/libevent2/include \
	$(JNI_PATH)/openssl/include/openssl \
	$(JNI_PATH)/openssl/include \
	$(JNI_PATH)/openssl


LOCAL_STATIC_LIBRARIES :=   libevent2 libcrypto libssl


LOCAL_CFLAGS := -O2 -std=gnu99 -Wall -fPIE -DUSE_IPTABLES -DUSE_CRYPTO_OPENSSL \
		-DUSE_CRYPTO_OPENSSL -DANDROID -DHAVE_CONFIG_H \
		-I$(LOCAL_PATH)/openssl/include/openssl \
		-I$(LOCAL_PATH)/libevent2/include

LOCAL_LDFLAGS += -fPIE -pie

include $(BUILD_EXECUTABLE)
