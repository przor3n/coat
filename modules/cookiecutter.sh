#!/bin/bash
export COOKIES_LIST="$HOME/.coat/storage/cookies"

makecookie() {
    exec $(cat ${COOKIES_LIST} | fzf)
}
