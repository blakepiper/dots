registerShortcut('Gentoo Screenshot region', 'Select a region and copy to clipboard', 'Meta+Shift+S', function() {
    callDBus('org.przvl.Screenshot', '/Screenshot', 'org.przvl.Screenshot', 'Capture');
});
