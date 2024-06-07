// ==UserScript==
// @name         Auto Skip YouTube Ads
// @version      1.0.0
// @description  Speed up and skip YouTube ads automatically
// @author       jso8910
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==
setInterval(() => {
    const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button,.ytp-ad-skip-button-modern, .ytp-skip-ad-button')
    if (btn) {
        setTimeout(function () { btn.click() }, 10)
    }
    const ad = [...document.querySelectorAll('.ad-showing')][0];
    if (ad) {
        document.querySelector('video').volume = 0;
        for (let i = 2; i < 16; i++) {
            document.querySelector('video').playbackRate = i;
        }
    }
}, 50)

