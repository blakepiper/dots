registerShortcut('KDE Screenshot region', 'Select a region and copy to clipboard', 'Meta+Shift+S', function() {
    callDBus('org.local.Screenshot', '/Screenshot', 'org.local.Screenshot', 'Capture');
});
