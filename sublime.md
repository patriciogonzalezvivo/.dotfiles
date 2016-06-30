```python 

import urllib.request,os,hashlib; h = 'eb2297e1a458f27d836c04bb0cbaf282' + 'd0e7a3098092775ccb37ca9d6b2e4b7d'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)

```

Install Packages:

- Material Theme
- glslViewer

Settings-user:
```
{
    "always_show_minimap_viewport": true,
    "bold_folder_labels": true,
    "color_scheme": "Packages/Material Theme/schemes/Material-Theme-Darker.tmTheme",
    "font_options":
    [
        "gray_antialias"
    ],
    "font_size": 13,
    "ignored_packages":
    [
        "Vintage"
    ],
    "line_padding_bottom": 3,
    "line_padding_top": 3,
    "overlay_scroll_bars": "enabled",
    "tab_size": 4,
    "theme": "Material-Theme-Darker.sublime-theme",
    "translate_tabs_to_spaces": true
}
```